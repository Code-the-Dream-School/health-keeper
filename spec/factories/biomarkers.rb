# frozen_string_literal: true

require 'faker'

BIOMARKER_NAMES = [
  'Glucose',
  'Hemoglobin',
  'Cholesterol',
  'Triglycerides',
  'Vitamin D',
  'LDL Cholesterol',
  'HDL Cholesterol',
  'Insulin',
  'C-Reactive Protein',
  'Calcium',
  'Potassium',
  'Sodium',
  'Iron',
  'Ferritin',
  'Thyroid Stimulating Hormone (TSH)',
  'Free T4',
  'Free T3',
  'Creatinine',
  'Blood Urea Nitrogen (BUN)',
  'Alkaline Phosphatase',
  'AST (SGOT)',
  'ALT (SGPT)',
  'Bilirubin',
  'Albumin',
  'Magnesium',
  'Neutrophils',
  'Lymphocytes',
  'Eosinophils',
  'Monocytes',
  'Basophils',
  'Platelet Count',
  'MPV'
].freeze

FactoryBot.define do
  factory :biomarker do
    sequence(:name) { |n| BIOMARKER_NAMES[n % BIOMARKER_NAMES.length] }
  end
end
