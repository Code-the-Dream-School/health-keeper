require 'rails_helper'

RSpec.describe 'Blood Test Management', type: :feature do
  let(:user) { create(:user) }
  let!(:biomarker) { create(:biomarker, name: 'Glucose') }
  let!(:reference_range) do
    create(:reference_range,
           biomarker: biomarker,
           min_value: 70,
           max_value: 99,
           unit: 'mg/dL')
  end

  before do
    sign_in user
    visit new_blood_test_lab_tests_path
  end

  it 'creates a blood test with valid data', :js do
    select 'Glucose', from: 'lab_test_biomarker_id'
    expect(page).to have_content("Reference Range: #{reference_range.min_value} - #{reference_range.max_value}")

    fill_in 'lab_test_value', with: '85'
    fill_in 'lab_test_notes', with: 'Morning test'

    expect(page).to have_selector("input[name='lab_test[reference_range_id]'][value='#{reference_range.id}']",
                                  visible: false)
    expect(page).to have_selector("input[name='lab_test[unit]'][value='#{reference_range.unit}']", visible: false)

    click_button 'Create Blood Test'

    expect(page).to have_content(/success|created/i)
    expect(LabTest.last.value).to eq(85.0)
  end

  it 'shows error for invalid data' do
    select 'Glucose', from: 'lab_test_biomarker_id'
    fill_in 'lab_test_value', with: '-5'

    click_button 'Create Blood Test'

    expect(page).to have_content(/error|invalid|must be greater than 0/i)
  end
end
