# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LabTest do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:biomarker) }
    it { is_expected.to belong_to(:recordable) }
    it { is_expected.to belong_to(:reference_range) }
  end

  describe 'validations' do
    subject(:lab_test) { build(:lab_test) }

    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:unit) }

    context 'value validations' do
      # it 'is invalid with a negative value' do
      #   lab_test.value = -1
      #   expect(lab_test).not_to be_valid
      #   expect(lab_test.errors[:value]).to include('must be a non-negative number')
      # end

      it 'is valid with zero' do
        lab_test.value = 0
        expect(lab_test).to be_valid
      end

      it 'is invalid with non-numeric value' do
        lab_test.value = 'abc'
        expect(lab_test).not_to be_valid
        expect(lab_test.errors[:value]).to include('is not a number')
      end

      it 'is valid with a positive number' do
        lab_test.value = 85.0
        expect(lab_test).to be_valid
      end
    end
  end
end
