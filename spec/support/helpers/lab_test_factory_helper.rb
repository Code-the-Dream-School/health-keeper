module LabTestFactoryHelper
  def create_lab_test(name, value, unit, min_value = nil, max_value = nil, notes = nil)
    biomarker = create(:biomarker, name: name)
    reference_range = create(:reference_range, min_value: min_value, max_value: max_value)
    create(:lab_test, 
      biomarker: biomarker,
      value: value,
      unit: unit,
      reference_range: reference_range,
      notes: notes
    )
  end
end 