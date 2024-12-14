FactoryBot.define do
  factory :health_record do
    association :user
    notes { 'Morning blood test' }
  end
end
