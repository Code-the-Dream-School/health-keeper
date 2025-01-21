class LabTestCategorizer
  include LabTestDataHelper

  def self.categorize(lab_tests)
    new(lab_tests).categorize
  end

  def initialize(lab_tests)
    @lab_tests = lab_tests
    @results = {}
    @unmatched_tests = []
  end

  def categorize
    return {} if @lab_tests.nil? || @lab_tests.empty?

    Rails.logger.debug "\n=== STARTING LAB TEST PROCESSING ==="
    Rails.logger.debug "Total lab tests to process: #{@lab_tests.size}"
    
    process_tests
    handle_unmatched_tests
    order_results
  end

  private

  def process_tests
    @lab_tests.each do |test|
      next unless test.biomarker

      test_data = build_test_data(test)
      process_single_test(test, test_data)
    end
  end

  def process_single_test(test, test_data)
    test_name = normalize_test_name(test.biomarker.name)
    category = find_matching_category(test_name)
    
    if category
      process_method_info(test_data)
      add_test_to_category(category, test_data)
    else
      @unmatched_tests << test.biomarker.name
    end
  end

  def process_method_info(test_data)
    return unless test_data[:method].present?

    # Handle method information in notes
    if test_data[:method].include?(' ')
      method_parts = test_data[:method].split(' ')
      if method_parts.first.downcase == 'calculated'
        test_data[:name] = "#{test_data[:name]} (Calculated)"
        test_data[:method] = method_parts[1..-1].join(' ')
      elsif method_parts.first.downcase == 'derived'
        test_data[:name] = "#{test_data[:name]} (Derived)"
        test_data[:method] = method_parts[1..-1].join(' ')
      else
        test_data[:method] = test_data[:method]
      end
    end

    # If no specific method is provided, derive it based on the test type
    if test_data[:method].blank?
      test_data[:method] = derive_method(test_data[:name])
    end
  end

  def derive_method(test_name)
    case test_name.downcase
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

  def find_matching_category(test_name)
    # Skip unknown tests
    return nil if test_name.start_with?('unknown test')

    # Try exact match first
    LAB_TEST_CATEGORIES.each do |category, config|
      return category if config[:tests].any? { |test| normalize_test_name(test) == test_name }
    end

    # Checks if the test name contains the category name, test name, if any word in the test name appears in the category, and if any word in the category appears in the test name
    LAB_TEST_CATEGORIES.each do |category, config|
      return category if config[:tests].any? { |test| standard_match?(test_name, normalize_test_name(test)) }
    end

    nil
  end

  def standard_match?(test_name, normalized_category)
    # Skip unknown tests
    return false if test_name.start_with?('unknown test')

    test_name.include?(normalized_category) || 
    normalized_category.include?(test_name) ||
    test_name.split(' ').any? { |word| normalized_category.include?(word) } ||
    normalized_category.split(' ').any? { |word| test_name.include?(word) }
  end

  def handle_unmatched_tests
    @unmatched_tests.each do |test_name|
      Rails.logger.error("Could not categorize test: #{test_name}")
    end
  end

  def order_results
    LAB_TEST_CATEGORIES.keys.each_with_object({}) do |category, hash|
      hash[category] = @results[category] if @results[category]
    end
  end

  def add_test_to_category(category, test_data)
    @results[category] ||= []
    @results[category] << test_data
  end
end 