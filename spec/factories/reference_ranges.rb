# frozen_string_literal: true

FactoryBot.define do
  factory :reference_range do
    biomarker
    min_value { 0.0 }
    max_value { 100.0 }
    unit { 'mg/dL' }
    source { 'Standard Lab' }

    trait :for_glucose do
      min_value { 70.0 }
      max_value { 99.0 }
      unit { 'mg/dL' }
    end

    trait :for_hemoglobin do
      min_value { 13.5 }
      max_value { 17.5 }
      unit { 'g/dL' }
    end

    trait :for_cholesterol do
      min_value { 125.0 }
      max_value { 200.0 }
      unit { 'mg/dL' }
    end

    trait :for_differential_count do
      min_value { 20.0 }
      max_value { 40.0 }
      unit { '%' }
    end
  end
end
