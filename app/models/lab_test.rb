# frozen_string_literal: true

class LabTest < ApplicationRecord
  belongs_to :user
  belongs_to :biomarker
  belongs_to :recordable, polymorphic: true, touch: true
  belongs_to :reference_range

  validates :unit, presence: true
  validates :value, presence: true,
                    numericality: {
                      greater_than_or_equal_to: 0,
                      message: :must_be_nonnegative_and_numeric
                    }

  scope :in_date_range, lambda { |start_date, end_date|
    scope = all
    scope = scope.where(created_at: Date.parse(start_date).beginning_of_day..) if start_date.present?
    scope = scope.where(created_at: ..Date.parse(end_date).end_of_day) if end_date.present?
    scope
  }

  scope :by_date, lambda { |date|
    where(created_at: date.all_day)
  }

  # Show all records, ordered by newest first
  scope :latest_records, lambda {
    order(created_at: :asc)
  }

  # Changed to descending order to match the requirement
  scope :ordered_by_date, lambda {
    order(created_at: :asc, id: :asc)
  }

  # here code with group by tests by day (...DISTINCT ON)
  # scope :latest_records, lambda {
  #   records = all.group_by { |record| record.created_at.to_date }
  #                .transform_values { |group| group.max_by(&:created_at) }
  #                .values
  #   where(id: records)
  # }

  class Status
    NORMAL = :normal
    HIGH = :high
    LOW = :low

    ALL = [NORMAL, HIGH, LOW].freeze
  end

  def within_reference_range?
    return false unless value && reference_range

    value.between?(reference_range.min_value, reference_range.max_value)
  end

  def status
    return nil unless value && reference_range
    return Status::NORMAL if within_reference_range?

    value > reference_range.max_value ? Status::HIGH : Status::LOW
  end
end
