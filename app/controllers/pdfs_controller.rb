class PdfsController < ApplicationController
  def index
    @pdfs = Pdf.all
    @pdf = Pdf.new
  end

  def new
    @pdf = Pdf.new
  end

  def show
    @pdf = Pdf.find(params[:id])
    @parsed_data = @pdf.processed_data
    
    if @parsed_data.present?
      ordered_data = {}
      @parsed_data.each do |category, tests|
        next if tests.empty?
        ordered_data[category] = tests
      end
      @parsed_data = ordered_data
    end
  end

  def create
    ActiveRecord::Base.transaction do
      # First create a health record
      health_record = HealthRecord.new(
        user: current_user || User.first, # Adjust based on your authentication setup
        notes: "Health record for PDF upload"
      )
      health_record.save!(validate: false)  # Skip validation for pdf_file requirement

      # Then create the PDF with the health record
      @pdf = Pdf.new(pdf_params)
      @pdf.health_record = health_record
      @pdf.user = current_user || User.first  # Adjust based on your authentication setup

      if @pdf.save
        ProcessPdfJob.perform_later(@pdf.id, params[:pdf][:scan_method])
        redirect_to pdf_path(@pdf), notice: 'PDF was successfully uploaded and is being processed.'
      else
        health_record.destroy  # Cleanup if PDF save fails
        @pdfs = Pdf.all
        render :index, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    @pdfs = Pdf.all
    flash.now[:alert] = "Error creating PDF: #{e.message}"
    render :index, status: :unprocessable_entity
  end

  def update
    @pdf = Pdf.find(params[:id])
    if @pdf.update(pdf_params)
      redirect_to @pdf, notice: 'Notes were successfully updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def delete_selected
    if params[:pdf_ids].present?
      pdfs = Pdf.where(id: params[:pdf_ids])
      
      # Delete associated files first
      pdfs.each do |pdf|
        pdf.file.purge if pdf.file.attached?
      end
      
      # Then delete the records
      deleted_count = pdfs.destroy_all.count
      
      flash[:notice] = "Successfully deleted #{deleted_count} PDF#{'s' if deleted_count != 1}"
    else
      flash[:alert] = "No PDFs were selected for deletion"
    end
    
    redirect_to pdfs_path
  end

  private

  def pdf_params
    params.require(:pdf).permit(:file, :scan_method, :notes)
  end

  def parse_pdf_content(pdf)
    return unless pdf.file.attached?

    temp_pdf = Tempfile.new(['temp_pdf', '.pdf'])
    temp_pdf.binmode
    temp_pdf.write(pdf.file.download)
    temp_pdf.close

    parser = PdfParsers::SterlingAccurisParser.new(temp_pdf.path)
    parser.parse
  ensure
    temp_pdf&.unlink
  end
end