# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LabTestsController do
  let(:user) { create(:user) }
  let(:biomarker) { create(:biomarker) }
  let(:reference_range) { create(:reference_range, biomarker: biomarker) }
  let(:health_record) { create(:health_record, user: user) }

  before do
    sign_in user
  end

  describe 'GET #new_blood_test' do
    it 'renders the new blood test form' do
      get :new_blood_test
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create_blood_test' do
    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          lab_test: {
            biomarker_id: biomarker.id,
            value: -5,
            unit: 'mg/dL',
            reference_range_id: reference_range.id
          }
        }
      end

      it 'does not create a blood test' do
        expect do
          post :create_blood_test, params: invalid_params
        end.not_to change(LabTest, :count)
      end

      it 'returns unprocessable entity status' do
        post :create_blood_test, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
