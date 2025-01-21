class PdfsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pdf, only: [:show, :update]

  def index
    authorize Pdf
    @pdfs = policy_scope(Pdf).order(created_at: :desc)
    @pdf = Pdf.new
  end

  def new
    authorize Pdf
    redirect_to pdfs_path
  end

  def show
    authorize @pdf
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
    authorize Pdf
    
    ActiveRecord::Base.transaction do
      # Create a health record
      health_record = HealthRecord.new(
        user: current_user,
        notes: "Health record for PDF upload"
      )
      health_record.save!(validate: false)  # Skip validation for pdf_file requirement

      # Create the PDF with the health record
      @pdf = Pdf.new(pdf_params)
      @pdf.health_record = health_record
      @pdf.user = current_user

      if @pdf.save
        ProcessPdfJob.perform_later(@pdf.id, params[:pdf][:scan_method])
        redirect_to pdf_path(@pdf), notice: 'PDF was successfully uploaded and is being processed.'
      else
        health_record.destroy  # Cleanup if PDF save fails
        @pdfs = policy_scope(Pdf)
        render :index, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    @pdfs = policy_scope(Pdf)
    flash.now[:alert] = "Error creating PDF: #{e.message}"
    render :index, status: :unprocessable_entity
  end

  def update
    authorize @pdf
    if @pdf.update(pdf_params)
      redirect_to @pdf, notice: 'Notes were successfully updated.'
    else
      render :show, status: :unprocessable_entity
    end
  end

  def delete_selected
    authorize Pdf
    if params[:pdf_ids].present?
      pdfs = policy_scope(Pdf).where(id: params[:pdf_ids])
      
      # Delete associated files to the PDF
      pdfs.each do |pdf|
        authorize pdf, :destroy?
        pdf.file.purge if pdf.file.attached?
      end
      
      # Delete the records
      deleted_count = pdfs.destroy_all.count
      
      flash[:notice] = "Successfully deleted #{deleted_count} PDF#{'s' if deleted_count != 1}"
    else
      flash[:alert] = "No PDFs were selected for deletion"
    end
    
    redirect_to pdfs_path
  end

  private

  def set_pdf
    @pdf = Pdf.find(params[:id])
  end

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

  def pdf_dropdown_item
    render partial: 'shared/pdf_dropdown_item', layout: false
  end
end