class ProcessPdfJob < ApplicationJob
  queue_as :default
  require 'pdf-reader'

  def perform(health_record_id)
    health_record = HealthRecord.find(health_record_id)
    return unless health_record.pdf_file.attached?

    begin
      Rails.logger.info "Processing PDF for HealthRecord ##{health_record_id}"
      
      pdf_content = extract_pdf_content(health_record.pdf_file)
      Rails.logger.info "PDF Content: #{pdf_content}"
      
      parsed_data = parse_pdf_content(pdf_content)
      Rails.logger.info "Parsed Data: #{parsed_data}"
      
      create_lab_tests(health_record, parsed_data[:lab_results])
      create_measurements(health_record, parsed_data[:measurements])
    rescue => e
      Rails.logger.error "Error processing PDF: #{e.message}"
    end
  end

  private

  def create_lab_tests(health_record, lab_results)
    lab_results.each do |result|
      Rails.logger.info "Creating lab test: #{result}"
      health_record.lab_tests.create!(
        name: result[:name],
        value: result[:value],
        unit: result[:unit],
        source: health_record.pdf_file.filename.to_s
      )
    end
  end

  def create_measurements(health_record, measurements)
    measurements.each do |type, data|
      Rails.logger.info "Creating measurement: #{type} - #{data}"
      health_record.measurements.create!(
        measurement_type: type,
        value: data,
        source: health_record.pdf_file.filename.to_s
      )
    end


  def extract_pdf_content(pdf_file)
    pdf_path = ActiveStorage::Blob.service.path_for(pdf_file.key)
    content = ""
    PDF::Reader.new(pdf_path).pages.each do |page|
      content += page.text
    end
    content
  end

  def parse_pdf_content(content)
    Rails.logger.info "Parsing content: #{content}"
    sections = content.split(/(?=Patient Information|Vital Signs|Measurements|Lab Results)/)
    
    {
      lab_results: extract_lab_values(sections.find { |s| s.start_with?('Lab Results') }.to_s),
      measurements: extract_measurements(sections.find { |s| s.start_with?('Measurements') }.to_s)
    }
  end

  def extract_lab_values(section)
    lab_tests = []
    section.scan(/([^:\n]+):\s*([\d.]+)\s*([\w\/]+)/) do |name, value, unit|
      lab_tests << {
        name: name.strip,
        value: value.to_f,
        unit: unit
      }
    end
    lab_tests
  end

  def extract_measurements(section)
    measurements = {}
    section.scan(/([^:\n]+):\s*([\d.]+)\s*([\w\/]+)/) do |type, value, unit|
      measurements[type.strip] = value.to_f
    end
    measurements
  end
end 