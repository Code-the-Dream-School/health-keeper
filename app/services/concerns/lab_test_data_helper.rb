module LabTestDataHelper
  SPECIAL_CASE_MATCHES = {
    'glucose' => 'sugar',
    'haemoglobin' => 'hb',
    'a1c' => ['hba1c', 'glycosylated'],
    'ldl' => 'ldl',
    'hdl' => 'hdl',
    'sgpt' => 'alt',
    'sgot' => 'ast',
    'esr' => 'erythrocyte sedimentation rate',
    'creatinine' => 'creatinine',
    'urea' => 'urea',
    'bilirubin' => 'bilirubin',
    'albumin' => 'albumin',
    'globulin' => 'globulin',
    'protein' => 'protein',
    'iron' => 'iron',
    'tibc' => 'iron binding capacity',
    'transferrin' => 'transferrin',
    'vitamin' => 'vitamin',
    'hbsag' => 'hbsag',
    'hiv' => 'hiv',
    'psa' => 'prostate',
    'ige' => 'ige',
    'hb a' => 'hb a',
    'foetal' => 'foetal',
    'concentration' => 'concentration',
    'urine' => 'urine',
    'cells' => 'cells',
    'casts' => 'casts',
    'crystals' => 'crystals'
  }.freeze

  def build_test_data(test)
    {
      name: test.biomarker.name,
      method: test.notes,
      value: test.value,
      unit: test.unit,
      reference_range: {
        min: test.reference_range&.min_value,
        max: test.reference_range&.max_value
      }
    }
  end

  def normalize_test_name(name)
    name.downcase
        .gsub(/^(pr|calculated|total)\s+/, '')
        .gsub(/\s*[-–]\s*/, ' ')
        .gsub(/[(),.]/, '')
        .gsub(/\s+/, ' ')
        .strip
  end

  def process_method_name(test_data)
    return unless test_data[:method].present? && test_data[:method].include?(' ')
    
    method_parts = test_data[:method].split(' ')
    test_data[:name] = "#{test_data[:name]} #{method_parts.first}"
    test_data[:method] = method_parts[1..-1].join(' ')
  end

  def handle_unmatched_test(test_name)
    error_message = "Could not categorize test: #{test_name}"
    Rails.logger.error("⚠️ #{error_message}")
    flash.now[:alert] = error_message if defined?(flash)
  end
end 