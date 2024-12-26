# frozen_string_literal: true

class LabTest < ApplicationRecord
  belongs_to :user
  belongs_to :biomarker
  belongs_to :recordable, polymorphic: true, touch: true
  belongs_to :reference_range

  validates :value, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 0,
                      message: lambda do |_object, data|
                        if data[:value].to_s.match?(/\A[+-]?\d+(\.\d+)?\z/)
                          'must be a non-negative number'
                        else
                          'is not a number'
                        end
                      end
                    }
  validates :unit, presence: true

  # Helper method to check if value is within reference range
  def within_reference_range?
    return false unless value && reference_range

    value.between?(reference_range.min_value, reference_range.max_value)
  end

  # Helper method to get the status of the value
  def status
    return nil unless value && reference_range
    return :normal if within_reference_range?

    value > reference_range.max_value ? :high : :low
  end
end
