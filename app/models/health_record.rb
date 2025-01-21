# frozen_string_literal: true

class HealthRecord < ApplicationRecord
  belongs_to :user
  has_many :lab_tests, as: :recordable, dependent: :destroy
  has_many :measurements, as: :recordable, dependent: :destroy
  has_one_attached :pdf_file

  validates :pdf_file, attached: true, 
            content_type: { in: 'application/pdf', message: 'must be a PDF' },
            size: { less_than: 10.megabytes, message: 'should be less than 10MB' }
  
  accepts_nested_attributes_for :lab_tests, :measurements
end
