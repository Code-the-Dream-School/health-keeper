class ProcessPdfJob < ApplicationJob
  queue_as :default

  def perform(pdf_id, scan_method)
    pdf = Pdf.find(pdf_id)
    return unless pdf.file.attached?

    begin
      Rails.logger.info "Starting PDF processing for ID: #{pdf_id}"
      pdf.update!(status: 'processing', scan_method: scan_method)
      
      temp_pdf = Tempfile.new(['temp_pdf', '.pdf'])
      temp_pdf.binmode
      temp_pdf.write(pdf.file.download)
      temp_pdf.close

      parser = PdfParsers::SterlingAccurisParser.new(temp_pdf.path)
      processed_data = parser.parse

      Rails.logger.info "Parsed data: #{processed_data.inspect}"

      # Explicitly save the processed data to the database
      result = pdf.update!(
        processed_data: processed_data,
        status: 'completed'
      )

      if result
        Rails.logger.info "Successfully saved processed data for PDF #{pdf_id}"
      else
        Rails.logger.error "Failed to save processed data: #{pdf.errors.full_messages}"
        pdf.update!(status: 'failed')
      end

    rescue => e
      Rails.logger.error "PDF Processing Error: #{e.message}\n#{e.backtrace.join("\n")}"
      pdf.update!(status: 'failed')
    ensure
      temp_pdf&.unlink
    end
  end
end 