module LabTestCategorization
  extend ActiveSupport::Concern

  LAB_TEST_CATEGORIES = {
    'Complete Blood Count' => {
      columns: ['Test', 'Method', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Hemoglobin',
        'RBC Count',
        'Hematocrit',
        'MCV',
        'MCH',
        'MCHC',
        'RDW CV'
      ]
    },
    'Total WBC and Differential Count' => {
      columns: ['Test', 'Method', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'WBC Count',
        'Neutrophils',
        'Lymphocytes',
        'Eosinophils',
        'Monocytes',
        'Basophils',
        'Platelet Count',
        'MPV',
        'Neutrophil',
        'Lymphocyte',
        'Eosinophil',
        'Monocyte',
        'Basophil',
        'Platelets',
        'Mean Platelet Volume'
      ]
    },
    'Peripheral Smear Examination' => {
      columns: ['Test', 'Result'],
      tests: [
        'RBC Morphology',
        'WBC Morphology',
        'Platelets Morphology',
        'Parasites',
        'Erythrocyte Sedimentation Rate',
        'ESR'
      ]
    },
    'Blood Group' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'ABO Type',
        'Rh (D) Type',
        'Blood Group',
        'Rh Type'
      ]
    },
    'Lipid Profile' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Cholesterol',
        'Total Cholesterol',
        'Triglyceride',
        'HDL Cholesterol',
        'Direct LDL',
        'LDL Cholesterol',
        'VLDL',
        'CHOL/HDL Ratio',
        'LDL/HDL Ratio'
      ]
    },
    'Biochemistry' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Fasting Blood Sugar',
        'HbA1c',
        'Glycosylated Hemoglobin',
        'Mean Blood Glucose',
        'Microalbumin',
        'Microalbumin (per urine volume)',
        'Creatinine',
        'Creatinine, Serum',
        'Urea',
        'Blood Urea Nitrogen',
        'Uric Acid',
        'Calcium',
        'SGPT',
        'SGOT',
        'ALT',
        'AST'
      ]
    },
    'Protein' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Total Protein',
        'Albumin',
        'Globulin',
        'A/G Ratio',
        'AG Ratio',
        'Total Bilirubin',
        'Conjugated Bilirubin',
        'Direct Bilirubin',
        'Unconjugated Bilirubin',
        'Indirect Bilirubin',
        'Delta Bilirubin'
      ]
    },
    'Iron Studies' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Iron',
        'Serum Iron',
        'Total Iron Binding Capacity',
        'TIBC',
        'Transferrin Saturation'
      ]
    },
    'Immunoassay' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Homocysteine',
        'Homocysteine, Serum',
        '25(OH) Vitamin D',
        'Vitamin D',
        'Vitamin B12',
        'PSA',
        'PSA-Prostate Specific Antigen',
        'PSA-Prostate Specific Antigen, Total',
        'IgE',
        'HIV I & II Ab/Ag with P24 Ag',
        'HBsAg'
      ]
    },
    'HB Electrophoresis By HPLC' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Hb A',
        'Hb A2',
        'P2 Peak',
        'P3 Peak',
        'Foetal Hb',
        'Interpretation'
      ]
    },
    'Bio-Rad CDM System' => {
      columns: ['Test', 'Result'],
      tests: [
        'F Concentration',
        'A2 Concentration'
      ]
    },
    'Physical & Chemical Examination' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Colour',
        'Clearity',
        'pH',
        'Specific Gravity',
        'Urine Glucose',
        'Urine Protein',
        'Bilirubin',
        'Urobilinogen',
        'Urine Ketone',
        'Nitrite'
      ]
    },
    'Microscopic Examination' => {
      columns: ['Test', 'Result', 'Unit', 'Biological Ref. Interval'],
      tests: [
        'Pus Cells',
        'Red Cells',
        'Epithelial Cells',
        'Casts',
        'Crystals',
        'Amorphous Material'
      ]
    }
  }.freeze

  TEST_METHODS = {
    'Hemoglobin' => 'Colorimetric',
    'WBC Count' => 'SF Cube cell analysis',
    'RBC Count' => 'Electrical impedance',
    'Hematocrit' => 'Calculated',
    'MCV' => 'Derived',
    'MCH' => 'Calculated',
    'MCHC' => 'Calculated',
    'RDW CV' => 'Calculated',
    'Platelets' => 'Electrical impedance',
    'HDL Cholesterol' => 'Direct measurement',
    'LDL Cholesterol' => 'Calculated',
    'VLDL' => 'Calculated',
    'Triglycerides' => 'Enzymatic',
    'Total Cholesterol' => 'Enzymatic',
    'Glucose' => 'Hexokinase',
    'HbA1c' => 'HPLC',
    'Creatinine' => 'Jaffe method',
    'Urea' => 'Urease',
    'SGPT/ALT' => 'IFCC without P5P',
    'SGOT/AST' => 'IFCC without P5P'
  }.freeze

  REFERENCE_RANGES = {
    'WBC Count' => { min: 4000, max: 10000, unit: 'thousand/cmm' },
    'Hemoglobin' => { min: 13, max: 17, unit: 'g/dL' },
    'RBC Count' => { min: 4.5, max: 5.5, unit: 'million/cmm' },
    'Hematocrit' => { min: 40, max: 50, unit: '%' },
    'MCV' => { min: 83, max: 101, unit: 'fL' },
    'MCH' => { min: 27, max: 32, unit: 'pg' },
    'MCHC' => { min: 32, max: 36, unit: 'g/dL' },
    'RDW CV' => { min: 11.6, max: 14.0, unit: '%' },
    'Platelets' => { min: 150000, max: 450000, unit: '/cmm' },
    'HDL Cholesterol' => { min: 40, max: 60, unit: 'mg/dL' },
    'LDL Cholesterol' => { min: 0, max: 100, unit: 'mg/dL' },
    'Total Cholesterol' => { min: 0, max: 200, unit: 'mg/dL' },
    'Triglycerides' => { min: 0, max: 150, unit: 'mg/dL' },
    'Fasting Blood Sugar' => { min: 74, max: 106, unit: 'mg/dL' },
    'HbA1c' => { min: 4, max: 5.6, unit: '%' },
    'Total Protein' => { min: 6.4, max: 8.2, unit: 'g/dL' },
    'Albumin' => { min: 3.5, max: 5.2, unit: 'g/dL' },
    'Globulin' => { min: 2.3, max: 3.5, unit: 'g/dL' },
    'A/G Ratio' => { min: 1.2, max: 2.2, unit: 'ratio' },
    'Total Bilirubin' => { min: 0.3, max: 1.2, unit: 'mg/dL' },
    'Conjugated Bilirubin' => { min: 0.0, max: 0.3, unit: 'mg/dL' },
    'Direct Bilirubin' => { min: 0.0, max: 0.3, unit: 'mg/dL' },
    'Unconjugated Bilirubin' => { min: 0.2, max: 0.9, unit: 'mg/dL' },
    'Indirect Bilirubin' => { min: 0.2, max: 0.9, unit: 'mg/dL' },
    'Delta Bilirubin' => { min: 0.0, max: 0.2, unit: 'mg/dL' }
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