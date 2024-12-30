class PdfsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pdf, only: [:show, :download, :view, :destroy]

  def index
    @pdfs = current_user.health_records.includes(:pdf_file_attachment)
  end

  def show
    if @pdf.pdf_file.attached?
      pdf_content = PDF::Reader.new(ActiveStorage::Blob.service.path_for(@pdf.pdf_file.key)).pages.map(&:text).join("\n")
      sections = pdf_content.split(/(?=Patient Information|Vital Signs|Measurements|Lab Results)/)
      
      @parsed_data = {
        patient_info: extract_section_data(sections, 'Patient Information'),
        vital_signs: extract_section_data(sections, 'Vital Signs'),
        measurements: extract_section_data(sections, 'Measurements'),
        lab_results: extract_lab_values(sections.find { |s| s.start_with?('Lab Results') }.to_s),
        notes: @pdf.notes || "No notes available"
      }
    else
      @parsed_data = {
        patient_info: { name: "No PDF attached", dob: "N/A", date: Time.current },
        vital_signs: { blood_pressure: "N/A", heart_rate: "N/A", temperature: "N/A" },
        measurements: { height: "N/A", weight: "N/A" },
        lab_results: [],
        notes: @pdf.notes || "No notes available"
      }
    end
  end

  def download
    authorize @pdf
    if @pdf.pdf_file.attached?
      send_data @pdf.pdf_file.download,
                filename: @pdf.pdf_file.filename.to_s,
                content_type: 'application/pdf'
    else
      redirect_to pdfs_path, alert: 'No PDF file attached'
    end
  end

  def view
    authorize @pdf
    if @pdf.pdf_file.attached?
      redirect_to rails_blob_path(@pdf.pdf_file, disposition: "inline")
    else
      redirect_to pdfs_path, alert: 'No PDF file attached'
    end
  end

  def create
    @health_record = current_user.health_records.build(health_record_params)

    if @health_record.save
      if @health_record.pdf_file.attached?
        begin
          # Extract source and content
          pdf_source = @health_record.pdf_file.filename.to_s || "PDF Upload #{Time.current}"
          puts "\n========== SOURCE INFO =========="
          puts "PDF Source: #{pdf_source}"
          puts "================================\n"
          
          pdf_path = ActiveStorage::Blob.service.path_for(@health_record.pdf_file.key)
          pdf_content = PDF::Reader.new(pdf_path).pages.map(&:text).join("\n")
          
          # Extract Measurements with corrected type names
          puts "\n========== MEASUREMENTS =========="
          measurements = {
            'height' => /Height:\s*(\d+)\s*cm/,
            'weight' => /Weight:\s*(\d+)\s*kg/,
            'blood_pressure' => /Blood Pressure:\s*(\d+\/\d+)/,
            'heart_rate' => /Heart Rate:\s*(\d+)/,
            'temperature' => /Temperature:\s*([\d.]+)/
          }

          measurements.each do |type, pattern|
            if match = pdf_content.match(pattern)
              puts "\nAttempting to create measurement:"
              puts "Type: #{type}"
              puts "Value: #{match[1]}"
              puts "Source: #{pdf_source}"
              
              measurement = Measurement.new(
                user: current_user,
                measurement_type: type,  # Use the lowercase type directly
                value: match[1],
                unit: type == 'height' ? 'cm' : (type == 'weight' ? 'kg' : ''),
                source: pdf_source,
                recordable: @health_record
              )
              
              if measurement.save
                puts "Successfully saved measurement: #{measurement.attributes}"
              else
                puts "Failed to save measurement: #{measurement.errors.full_messages}"
              end
            end
          end
          puts "================================\n"

          # Extract Lab Results
          if pdf_content.include?('Lab Results')
            lab_section = pdf_content.split('Lab Results').last.split('Notes').first
            puts "\n========== LAB RESULTS =========="
            puts "Lab Section Content:"
            puts lab_section
            
            lab_section.each_line do |line|
              next if line.include?('Test') || line.strip.empty?
              parts = line.strip.split(/\t|\s+/)
              
              if parts.length >= 3
                puts "\nProcessing Lab Test:"
                puts "Name: #{parts[0]}"
                puts "Value: #{parts[1]}"
                puts "Unit: #{parts[2]}"
                
                biomarker = Biomarker.find_or_create_by!(name: parts[0])
                reference_range = ReferenceRange.find_or_create_by!(
                  biomarker: biomarker,
                  min_value: 0,
                  max_value: 100,
                  unit: parts[2]
                )
                
                lab_test = @health_record.lab_tests.create!(
                  user: current_user,
                  biomarker: biomarker,
                  reference_range: reference_range,
                  value: parts[1].to_f,
                  unit: parts[2]
                )
                puts "Saved Lab Test: #{lab_test.attributes}"
              end
            end
            puts "================================\n"
          end

          redirect_to pdfs_path, notice: 'PDF uploaded and data extracted successfully.'
        rescue => e
          puts "\n========== ERROR =========="
          puts "Error Message: #{e.message}"
          puts "Backtrace:\n#{e.backtrace.join("\n")}"
          puts "===========================\n"
          redirect_to pdfs_path, alert: "Error processing PDF: #{e.message}"
        end
      end
    else
      redirect_to pdfs_path, alert: @health_record.errors.full_messages.join(', ')
    end
  end

  def destroy
    authorize @pdf
    @pdf.destroy
    redirect_to pdfs_path, notice: 'Health record was successfully deleted.'
  end

  private

  def set_pdf
    @pdf = HealthRecord.find(params[:id])
  end

  def health_record_params
    params.require(:health_record).permit(:pdf_file, :notes)
  end

  def extract_section_data(sections, section_name)
    section = sections.find { |s| s.start_with?(section_name) }
    return {} unless section

    case section_name
    when 'Patient Information'
      {
        name: extract_value(section, 'Patient Name'),
        dob: extract_value(section, 'Date of Birth'),
        date: extract_value(section, 'Date')
      }
    when 'Vital Signs'
      {
        blood_pressure: extract_value(section, 'Blood Pressure'),
        heart_rate: extract_value(section, 'Heart Rate'),
        temperature: extract_value(section, 'Temperature')
      }
    when 'Measurements'
      {
        height: extract_value(section, 'Height'),
        weight: extract_value(section, 'Weight')
      }
    end
  end

  def extract_value(text, key)
    match = text.match(/#{key}:\s*([^\n]+)/)
    match ? match[1].strip : "Not found"
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
end