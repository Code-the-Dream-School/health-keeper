module LabTestCategorization
  extend ActiveSupport::Concern

  SPECIAL_TEST_MAPPINGS = {
    'glucose' => ['sugar'],
    'haemoglobin' => ['hb'],
    'a1c' => ['hba1c', 'glycosylated'],
    'ldl' => ['ldl'],
    'hdl' => ['hdl'],
    'sgpt' => ['alt'],
    'sgot' => ['ast'],
    'esr' => ['erythrocyte sedimentation rate'],
    'creatinine' => ['creatinine'],
    'urea' => ['urea'],
    'bilirubin' => ['bilirubin'],
    'albumin' => ['albumin'],
    'globulin' => ['globulin'],
    'protein' => ['protein'],
    'iron' => ['iron'],
    'tibc' => ['iron binding capacity'],
    'transferrin' => ['transferrin'],
    'vitamin' => ['vitamin'],
    'hbsag' => ['hbsag'],
    'hiv' => ['hiv'],
    'psa' => ['prostate'],
    'ige' => ['ige'],
    'hb a' => ['hb a'],
    'foetal' => ['foetal'],
    'concentration' => ['concentration'],
    'urine' => ['urine'],
    'cells' => ['cells'],
    'casts' => ['casts'],
    'crystals' => ['crystals']
  }.freeze

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

      # Finding the category for this test
      category_found = false
      
      # First, exact keyword match
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

    # Sorting categories according to their order in LAB_TEST_CATEGORIES
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
      
      # Check special mappings
      return true if SPECIAL_TEST_MAPPINGS.any? do |test_key, category_values|
        test_name.include?(test_key) && category_values.any? { |value| normalized_category.include?(value) }
      end

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
