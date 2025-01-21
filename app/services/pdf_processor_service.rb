class PdfProcessorService
  def initialize(pdf_path)
    @pdf_path = pdf_path
    @results = {}
    @debug_info = []
  end

  def process
    begin
      text_content = extract_text_from_pdf
      process_tables(text_content)
      { success: true, results: @results, debug: @debug_info }
    rescue => e
      log_debug("Error processing PDF: #{e.message}")
      { success: false, error: e.message, debug: @debug_info }
    end
  end

  private

  def extract_text_from_pdf
    log_debug("Starting PDF text extraction")
    PDF::Reader.new(@pdf_path).pages.map(&:text).join("\n")
  end

  def process_tables(content)
    LAB_TEST_CATEGORIES.each do |category, config|
      log_debug("Processing category: #{category}")
      @results[category] = []
      
      config[:tests].each do |test_name|
        test_data = extract_test_data(content, test_name, config[:columns])
        @results[category] << test_data if test_data
      end
    end
  end

  def extract_test_data(content, test_name, columns)
    log_debug("Extracting data for test: #{test_name}")
    
    test_line = content.split("\n").find { |line| line.match?(/#{Regexp.escape(test_name)}/) }
    return create_not_found_result(test_name, columns) unless test_line

    result = {
      name: test_name,
      method: columns.include?('Method') ? extract_method(test_line, test_name) : nil,
      result: extract_result(test_line),
      unit: columns.include?('Unit') ? extract_unit(test_line) : nil,
      reference_range: columns.include?('Biological Ref. Interval') ? extract_reference_range(test_line) : nil,
      absolute_count: columns.include?('Absolute Count') ? extract_absolute_count(test_line) : nil
    }.compact

    log_debug("Extracted data: #{result.inspect}")
    result
  end

  def extract_method(line, test_name)
    TEST_METHODS[test_name] || extract_pattern_from_line(line, /Method:\s*([^\s]+)/) || 'Not specified'
  end

  def extract_result(line)
    result = extract_pattern_from_line(line, /H?\s*(\d+\.?\d*)/)
    result.present? ? result : '-'
  end

  def extract_unit(line)
    unit = extract_pattern_from_line(line, /(\w+\/\w+|\w+)(?=\s+\d+\s*-\s*\d+)/)
    unit.present? ? unit : 'Not specified'
  end

  def extract_reference_range(line)
    if match = line.match(/(\d+\.?\d*)\s*-\s*(\d+\.?\d*)/)
      { min: match[1].to_f, max: match[2].to_f }
    else
      DEFAULT_RANGES[test_name] || { min: nil, max: nil }
    end
  end

  def create_not_found_result(test_name, columns)
    {
      name: test_name,
      method: columns.include?('Method') ? 'Not Found' : nil,
      result: 'Not Found',
      unit: columns.include?('Unit') ? 'Not Found' : nil,
      reference_range: columns.include?('Biological Ref. Interval') ? { min: nil, max: nil } : nil,
      absolute_count: columns.include?('Absolute Count') ? 'Not Found' : nil
    }.compact
  end

  def extract_pattern_from_line(line, pattern)
    match = line.match(pattern)
    match ? match[1] : nil
  end

  def extract_absolute_count(line)
    extract_pattern_from_line(line, /Absolute Count:\s*(\d+\.?\d*)/)
  end

  def log_debug(message)
    @debug_info << "#{Time.current}: #{message}"
    Rails.logger.debug(message)
  end
end 