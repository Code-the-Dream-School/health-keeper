module PdfParsers
  class UmcPathologyParser
    def initialize(pdf_path)
      @pdf_path = pdf_path
      @processed_data = {
        'patient_info' => {},
        'categories' => {
          'Basic Metabolic Panel' => [],
          'Complete Blood Count' => [],
          'Other Tests' => []
        }
      }
      @current_category = nil
      @debug_info = []
      
      Rails.logger.debug "Initialized UMC Pathology Parser with path: #{pdf_path}"
    end

    def parse
      Rails.logger.info "Starting UMC Pathology parse"
      begin
        reader = PDF::Reader.new(@pdf_path)
        
        reader.pages.each_with_index do |page, index|
          Rails.logger.debug "Processing page #{index + 1}"
          text = page.text
          lines = text.split("\n").map(&:strip).reject(&:empty?)
          
          parse_patient_info(text)
          parse_test_results(lines)
        end

        Rails.logger.info "Parsing completed successfully"
        Rails.logger.debug "Final data: #{@processed_data.inspect}"
        @processed_data
      rescue => e
        Rails.logger.error "Parser Error: #{e.message}\n#{e.backtrace.join("\n")}"
        raise e
      end
    end

    private

    def parse_test_results(lines)
      lines.each do |line|
        add_debug("Processing line: #{line}")
        
        # Try to identify category
        if line.match?(/CHEMISTRY|HEMATOLOGY|COAGULATION|URINALYSIS/i)
          @current_category = categorize_line(line)
          add_debug("Found category: #{@current_category}")
          next
        end

        # Try to parse test line if we're in a category
        if @current_category && (test_data = extract_test_data(line))
          add_debug("Found test data: #{test_data.inspect}")
          @processed_data['categories'][@current_category] << test_data
        end
      end
    end

    def categorize_line(line)
      case line.upcase
      when /CHEMISTRY/
        'Basic Metabolic Panel'
      when /HEMATOLOGY|CBC|BLOOD COUNT/
        'Complete Blood Count'
      else
        'Other Tests'
      end
    end

    def extract_test_data(line)
      # Various test patterns
      patterns = [
        /^([\w\s\-\(\)]+?)\s+([\d\.]+)\s*([HL]?)\s+([\w\/]+)\s*(?:\(([\d\.-]+)\))?/,
        /^([\w\s\-\(\)]+?):\s*([\d\.]+)\s*([HL]?)\s+([\w\/]+)/
      ]

      patterns.each do |pattern|
        if match = line.match(pattern)
          name, value, flag, unit, ref_range = match.captures
          return {
            'name' => name.strip,
            'value' => value,
            'flag' => flag.presence,
            'unit' => unit,
            'method' => determine_method(name.strip),
            'reference_range' => parse_reference_range(ref_range),
            'status' => 'Final'
          }
        end
      end
      nil
    end

    def determine_method(test_name)
      case test_name.downcase
      when /glucose|sodium|potassium|chloride|calcium/
        'Chemistry'
      when /hemoglobin|hematocrit|wbc|rbc|platelet/
        'Hematology'
      else
        'Laboratory'
      end
    end

    def parse_reference_range(range)
      return { 'min' => nil, 'max' => nil } unless range
      if match = range.match(/(\d+\.?\d*)\s*-\s*(\d+\.?\d*)/)
        { 'min' => match[1], 'max' => match[2] }
      else
        { 'min' => nil, 'max' => nil }
      end
    end

    def add_debug(message)
      timestamp = Time.now.strftime("%H:%M:%S.%L")
      debug_message = "[#{timestamp}] #{message}"
      @debug_info << debug_message
      Rails.logger.debug(debug_message)
    end
  end
end 