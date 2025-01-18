module LabTestCategorization
  extend ActiveSupport::Concern

  def format_lab_results(lab_tests)
    Rails.logger.debug "\n=== STARTING LAB TEST PROCESSING ==="
    Rails.logger.debug "Total lab tests to process: #{lab_tests.size}"
    
    results = {}
    unmatched_tests = []

    lab_tests.each do |test|
      next unless test.biomarker

      test_data = {
        name: test.biomarker.name,
        method: test.notes,
        value: test.value,
        unit: test.unit,
        reference_range: {
          min: test.reference_range&.min_value,
          max: test.reference_range&.max_value
        }
      }

      # Clean up test name for matching
      test_name = test.biomarker.name
                     .downcase
                     .gsub(/^(pr|calculated|total)\s+/, '') # Remove common prefixes
                     .gsub(/\s*[-–]\s*/, ' ')              # Normalize dashes
                     .gsub(/[(),.]/, '')                   # Remove punctuation
                     .gsub(/\s+/, ' ')                     # Normalize spaces
                     .strip

      # Try to find the category for this test
      category_found = false
      
      # First, try exact match
      LAB_TEST_CATEGORIES.each do |category, config|
        if config[:tests].any? { |t| normalize_test_name(t) == test_name }
          add_test_to_category(results, category, test_data)
          category_found = true
          Rails.logger.debug "✓ EXACT MATCH: '#{test.biomarker.name}' -> '#{category}'"
          break
        end
      end

      # If no exact match, try fuzzy matching
      unless category_found
        LAB_TEST_CATEGORIES.each do |category, config|
          if match_test_name?(test_name, config[:tests])
            add_test_to_category(results, category, test_data)
            category_found = true
            Rails.logger.debug "✓ FUZZY MATCH: '#{test.biomarker.name}' -> '#{category}'"
            break
          end
        end
      end

      unless category_found
        error_message = "⚠️ Could not categorize test: #{test.biomarker.name}"
        Rails.logger.error(error_message)
        unmatched_tests << test.biomarker.name
      end
    end

    # Sort categories according to their order in LAB_TEST_CATEGORIES
    ordered_results = LAB_TEST_CATEGORIES.keys.each_with_object({}) do |category, hash|
      hash[category] = results[category] if results[category]
    end

    # Add flash message for unmatched tests if any exist
    if unmatched_tests.any?
      error_message = "The following tests could not be categorized: #{unmatched_tests.join(', ')}"
      Rails.logger.error(error_message)
      if defined?(flash)
        flash.now[:alert] = error_message
      end
    end

    ordered_results
  end

  private

  def normalize_test_name(name)
    name.downcase
        .gsub(/^(pr|calculated|total)\s+/, '')
        .gsub(/\s*[-–]\s*/, ' ')
        .gsub(/[(),.]/, '')
        .gsub(/\s+/, ' ')
        .strip
  end

  def match_test_name?(test_name, category_tests)
    normalized_test = test_name.downcase
    
    category_tests.any? do |category_test|
      normalized_category = normalize_test_name(category_test)
      
      # Special case handling
      return true if test_name.include?('glucose') && normalized_category.include?('sugar')
      return true if test_name.include?('haemoglobin') && normalized_category.include?('hb')
      return true if test_name.include?('a1c') && (normalized_category.include?('hba1c') || normalized_category.include?('glycosylated'))
      return true if test_name.include?('ldl') && normalized_category.include?('ldl')
      return true if test_name.include?('hdl') && normalized_category.include?('hdl')
      return true if test_name.include?('sgpt') && normalized_category.include?('alt')
      return true if test_name.include?('sgot') && normalized_category.include?('ast')
      return true if test_name.include?('esr') && normalized_category.include?('erythrocyte sedimentation rate')
      return true if test_name.include?('creatinine') && normalized_category.include?('creatinine')
      return true if test_name.include?('urea') && normalized_category.include?('urea')
      return true if test_name.include?('bilirubin') && normalized_category.include?('bilirubin')
      return true if test_name.include?('albumin') && normalized_category.include?('albumin')
      return true if test_name.include?('globulin') && normalized_category.include?('globulin')
      return true if test_name.include?('protein') && normalized_category.include?('protein')
      return true if test_name.include?('iron') && normalized_category.include?('iron')
      return true if test_name.include?('tibc') && normalized_category.include?('iron binding capacity')
      return true if test_name.include?('transferrin') && normalized_category.include?('transferrin')
      return true if test_name.include?('vitamin') && normalized_category.include?('vitamin')
      return true if test_name.include?('hbsag') && normalized_category.include?('hbsag')
      return true if test_name.include?('hiv') && normalized_category.include?('hiv')
      return true if test_name.include?('psa') && normalized_category.include?('prostate')
      return true if test_name.include?('ige') && normalized_category.include?('ige')
      return true if test_name.include?('hb a') && normalized_category.include?('hb a')
      return true if test_name.include?('foetal') && normalized_category.include?('foetal')
      return true if test_name.include?('concentration') && normalized_category.include?('concentration')
      return true if test_name.include?('urine') && normalized_category.include?('urine')
      return true if test_name.include?('cells') && normalized_category.include?('cells')
      return true if test_name.include?('casts') && normalized_category.include?('casts')
      return true if test_name.include?('crystals') && normalized_category.include?('crystals')
      
      # Standard matching
      normalized_test.include?(normalized_category) || 
      normalized_category.include?(normalized_test) ||
      normalized_test.split(' ').any? { |word| normalized_category.include?(word) } ||
      normalized_category.split(' ').any? { |word| normalized_test.include?(word) }
    end
  end

  def add_test_to_category(results, category, test_data)
    results[category] ||= []
    
    # Separate methods into test names if they exist
    if test_data[:method].present? && test_data[:method].include?(' ')
      method_parts = test_data[:method].split(' ')
      test_data[:name] = "#{test_data[:name]} #{method_parts.first}"
      test_data[:method] = method_parts[1..-1].join(' ')
    end
    
    results[category] << test_data
  end
end 
