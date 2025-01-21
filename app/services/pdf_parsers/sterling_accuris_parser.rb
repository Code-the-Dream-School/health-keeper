module PdfParsers
  class SterlingAccurisParser
    SPECIAL_TEST_MAPPINGS = {
      'HB' => 'Hemoglobin',
      'RBC' => 'RBC Count',
      'HCT' => 'Hematocrit',
      'WBC' => 'WBC Count',
      'PLT' => 'Platelet Count'
    }.freeze

    UNIT_MAPPINGS = {
      'gm/dl' => 'g/dL',
      'mg/dl' => 'mg/dL',
      'mill/cumm' => '10^6/µL',
      'thou/cumm' => '10^3/µL',
      'mg/L' => 'mg/L',
      'g/L' => 'g/L',
      'U/L' => 'U/L',
      'mEq/L' => 'mEq/L',
      'µmol/L' => 'µmol/L',
      'ng/mL' => 'ng/mL',
      'pg/mL' => 'pg/mL',
      'mIU/L' => 'mIU/L',
      'IU/mL' => 'IU/mL',
      '%' => '%',
      'fL' => 'fL',
      'pg' => 'pg',
      'mm/hr' => 'mm/hr'
    }.freeze

    RESULT_PATTERNS = {
      normal_range: /(\d+\.?\d*)\s*-\s*(\d+\.?\d*)/,
      less_than: /[<＜]\s*(\d+\.?\d*)/,
      greater_than: /[>＞]\s*(\d+\.?\d*)/,
      approximate: /[~≈]\s*(\d+\.?\d*)/,
      decimal: /\d+\.\d+/,
      integer: /\d+/,
      percentage: /\d+\.?\d*\s*%/,
      ratio: /\d+\.?\d*\s*:\s*\d+\.?\d*/,
      text_result: /(?:normal|abnormal|positive|negative|present|absent|nil|none)/i
    }.freeze

    def initialize(pdf_path)
      @pdf_path = pdf_path
      @current_section = nil
      @processed_data = ActiveSupport::OrderedHash.new { |h, k| h[k] = [] }
      @multi_line_test = nil
      @multi_line_data = []
      @pending_interpretations = {}
      @section_order = []
    end

    def parse
      text = extract_text_from_pdf
      lines = text.split("\n").map(&:strip).reject(&:empty?)
      
      lines.each_with_index do |line, index|
        next_line = lines[index + 1]
        process_line(line, next_line)
      end

      # Process any remaining multi-line data
      finalize_multi_line_test if @multi_line_test

      # Return data in the order sections were found
      ordered_data = ActiveSupport::OrderedHash.new
      @section_order.each do |section|
        ordered_data[section] = @processed_data[section] if @processed_data[section].present?
      end
      ordered_data
    end

    private

    def extract_text_from_pdf
      reader = PDF::Reader.new(@pdf_path)
      reader.pages.map(&:text).join("\n")
    end

    def process_line(line, next_line)
      # Handle interpretation notes
      if line.match?(/interpretation|comment|note/i)
        process_interpretation(line)
        return
      end

      # Handle continuation of interpretation
      if @current_interpretation
        process_interpretation_continuation(line)
        return
      end

      # Check if line is a section header
      if is_section_header?(line)
        finalize_multi_line_test if @multi_line_test
        @current_section = find_matching_section(line)
        @section_order << @current_section unless @section_order.include?(@current_section)
        return
      end

      return unless @current_section

      section_data = SterlingAccurisStructure::STRUCTURE[@current_section]
      return unless section_data

      # Handle multi-line test data
      if @multi_line_test
        if is_continuation_line?(line)
          @multi_line_data << line
          return
        else
          finalize_multi_line_test
        end
      end

      # Try to match test data
      section_data[:tests].each do |test|
        if line_matches_test?(line, test)
          process_test_line(line, test, next_line)
          break
        end
      end
    end

    def is_section_header?(line)
      SterlingAccurisStructure::STRUCTURE.keys.any? do |header|
        line.match?(/#{Regexp.escape(header)}/i)
      end
    end

    def find_matching_section(line)
      SterlingAccurisStructure::STRUCTURE.keys.find do |header|
        line.match?(/#{Regexp.escape(header)}/i)
      end
    end

    def line_matches_test?(line, test)
      # Handle cases where test names might have slight variations
      line.match?(/^#{Regexp.escape(test)}[\s:\t]/i)
    end

    def is_continuation_line?(line)
      # Check if line appears to be a continuation of previous data
      !line.match?(/^[\w\s]{1,50}[\s:\t]/) && 
        (line.match?(/^\s*[\d\.,]+/) || line.match?(/^\s*[<>]/) || line.match?(/^\s*[-+]?[\d\.]/) || line.match?(/^\s*[A-Za-z\s,]+$/))
    end

    def process_test_line(line, test, next_line)
      section_data = SterlingAccurisStructure::STRUCTURE[@current_section]
      columns = section_data[:columns]
      
      # Remove the test name from the line
      data_part = line[test.length..].strip
      
      # Check if this is the start of a multi-line test
      if needs_next_line?(data_part, columns.length) && next_line && is_continuation_line?(next_line)
        @multi_line_test = test
        @multi_line_data = [data_part]
        return
      end

      process_test_data(test, data_part)
    end

    def needs_next_line?(data_part, expected_columns)
      # Check if we have fewer values than expected columns
      values = split_values(data_part)
      values.length < expected_columns - 1  # -1 because 'Test' column is already handled
    end

    def split_values(data_part)
      # Handle various separators and formats
      values = data_part.split(/\s{2,}|\t|(?<=\d)\s(?=[\d<>])|(?<=\))\s(?=[\d<>])/)
      
      # Clean up values
      values.map do |value|
        clean_value(value)
      end.reject(&:empty?)
    end

    def clean_value(value)
      # Handle special characters and formatting
      value = value.strip
      value = value.gsub(/^[:\s]+|[:\s]+$/, '')  # Remove leading/trailing colons and spaces
      value = handle_numeric_values(value)
      value = handle_special_notations(value)
      value = standardize_units(value)
      value
    end

    def standardize_units(value)
      # Standardize common unit variations
      {
        'gm/dl' => 'g/dL',
        'mg/dl' => 'mg/dL',
        'mill/cumm' => '10^6/µL',
        'thou/cumm' => '10^3/µL'
      }.each do |from, to|
        value = value.gsub(/#{Regexp.escape(from)}/i, to)
      end
      value
    end

    def handle_numeric_values(value)
      RESULT_PATTERNS.each do |type, pattern|
        case type
        when :less_than
          value = value.gsub(pattern, '< \1')
        when :greater_than
          value = value.gsub(pattern, '> \1')
        when :approximate
          value = value.gsub(pattern, '≈ \1')
        when :decimal, :integer
          # Ensure consistent decimal formatting
          if value.match?(pattern)
            num = value.to_f
            value = num.zero? ? '0' : format('%.2f', num).sub(/\.?0+$/, '')
          end
        end
      end
      value
    end

    def handle_special_notations(value)
      # Handle special result notations
      value = value.gsub(/\bNIL\b/i, 'Not Detected')
      value = value.gsub(/\bN\.A\./i, 'Not Applicable')
      value = value.gsub(/\bW\.N\.L\./i, 'Within Normal Limits')
      value = value.gsub(/\bN\b/i, 'Normal') unless value.match?(/\d+\s*N\b/) # Don't replace N in quantities
      
      # Handle plus/minus notations
      value = value.gsub(/\b(\+{1,4})\b/) { |m| "Positive (#{m.length}+)" }
      value = value.gsub(/\b(-{1,4})\b/, 'Negative')
      
      value
    end

    def finalize_multi_line_test
      return unless @multi_line_test
      
      # Combine all lines of data
      combined_data = @multi_line_data.join(' ')
      process_test_data(@multi_line_test, combined_data)
      
      # Reset multi-line tracking
      @multi_line_test = nil
      @multi_line_data = []
    end

    def process_test_data(test, data_part)
      test = SPECIAL_TEST_MAPPINGS[test] || test
      
      values = split_values(data_part)
      section_data = SterlingAccurisStructure::STRUCTURE[@current_section]
      columns = section_data[:columns]
      
      test_data = {
        name: test,
        method: nil,
        value: nil,
        unit: nil,
        biological_ref_interval: '-'
      }
      
      case @current_section
      when "Blood Group"
        test_data[:value] = values.first || '-'
        test_data[:method] = 'Blood Typing'
        test_data[:unit] = '-'
      when "Peripheral Smear Examination"
        test_data[:value] = values.join(' ').presence || '-'
        test_data[:method] = 'Microscopy'
      else
        columns[1..].each_with_index do |column, index|
          value = values[index]&.strip
          
          case column
          when 'Method'
            test_data[:method] = value.presence || '-'
          when 'Result'
            test_data[:value] = value.presence || '-'
          when 'Unit'
            test_data[:unit] = value.presence || '-'
          when 'Biological Ref. Interval'
            if value&.match?(/(\d+\.?\d*)\s*-\s*(\d+\.?\d*)/)
              test_data[:biological_ref_interval] = value
            elsif value.present?
              test_data[:biological_ref_interval] = value
            else
              test_data[:biological_ref_interval] = '-'
            end
          end
        end
      end

      # Handle missing method
      test_data[:method] ||= derive_method(test)
      
      # Add any pending interpretations
      if @pending_interpretations[test]
        test_data[:interpretation] = @pending_interpretations[test]
        @pending_interpretations.delete(test)
      end

      # Add test data to the current section while maintaining order
      @processed_data[@current_section] << test_data
    end

    def derive_method(test)
      case test.downcase
      when /hemoglobin|hb|rbc|wbc|plt|hct|mcv|mch|mchc|rdw|mpv/i
        'Flow Cytometry'
      when /glucose|sugar|urea|creatinine|uric acid|bun/i
        'Spectrophotometry'
      when /protein|albumin|globulin|bilirubin|sgot|sgpt|alp|ggt/i
        'Colorimetry'
      when /thyroid|t3|t4|tsh|ft3|ft4/i
        'Chemiluminescence'
      when /vitamin|b12|d3|folate/i
        'ECLIA'
      when /sodium|potassium|chloride|bicarbonate/i
        'Ion Selective Electrode'
      when /calcium|phosphorus|magnesium/i
        'Arsenazo'
      when /lipid|cholesterol|triglycerides|hdl|ldl/i
        'Enzymatic'
      when /iron|tibc|ferritin/i
        'Ferrozine'
      when /esr|sed rate/i
        'Westergren'
      when /blood group|rh typing/i
        'Agglutination'
      when /peripheral smear/i
        'Microscopy'
      else
        'Automated Analysis'
      end
    end

    def process_interpretation(line)
      section = find_interpretation_section(line)
      if section
        @current_interpretation = {
          section: section,
          text: line.sub(/^.*?:/i, '').strip
        }
      end
    end

    def process_interpretation_continuation(line)
      return unless @current_interpretation

      if line.match?(/^[A-Z][\w\s]+:/) # New section started
        finalize_interpretation
      else
        @current_interpretation[:text] += " #{line.strip}"
      end
    end

    def finalize_interpretation
      return unless @current_interpretation

      section = @current_interpretation[:section]
      text = @current_interpretation[:text]

      @processed_data[section] ||= []
      @processed_data[section] << {
        name: 'Interpretation',
        value: text,
        method: 'Analysis',
        unit: 'N/A',
        reference_range: { min: nil, max: nil }
      }

      @current_interpretation = nil
    end

    def find_interpretation_section(line)
      SterlingAccurisStructure::STRUCTURE.keys.find do |section|
        line.match?(/#{Regexp.escape(section)}/i) ||
          (section.match?(/blood|thyroid|lipid|protein/i) && line.match?(/#{section.split.first}/i))
      end
    end
  end
end 