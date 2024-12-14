FactoryBot.define do
  factory :lab_test do
    association :user
    association :biomarker
    association :reference_range
    association :recordable, factory: :health_record
    value { 85.0 }
    unit { 'mg/dL' }
    notes { 'Regular checkup' }
  end
end
