require 'rails_helper'

RSpec.describe "LabTestCategorization" do
  let(:dummy_class) { Class.new { include LabTestCategorization } }
  let(:instance) { dummy_class.new }

  describe "#format_lab_results" do
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

    it "correctly categorizes Differential Count tests" do
      tests = [
        create_lab_test("Neutrophils", "60", "%", "40", "80"),
        create_lab_test("Lymphocytes", "30", "%", "20", "40"),
        create_lab_test("Eosinophils", "2", "%", "1", "6"),
        create_lab_test("Monocytes", "5", "%", "2", "10"),
        create_lab_test("Basophils", "1", "%", "0", "2"),
        create_lab_test("Platelet Count", "250000", "/cmm", "150000", "450000"),
        create_lab_test("MPV", "10", "fL", "7.4", "10.4")
      ]

      results = instance.format_lab_results(tests)
      expect(results['Differential Count']).to be_present
      expect(results['Differential Count'].map { |t| t[:name] }).to match_array([
        'Neutrophils', 'Lymphocytes', 'Eosinophils', 'Monocytes', 'Basophils', 
        'Platelet Count', 'MPV'
      ])
    end

    it "correctly categorizes Peripheral Smear Examination tests" do
      tests = [
        create_lab_test("RBC Morphology", "Normal", nil),
        create_lab_test("WBC Morphology", "Normal", nil),
        create_lab_test("Platelets Morphology", "Adequate", nil),
        create_lab_test("Parasites", "Not Seen", nil),
        create_lab_test("Erythrocyte Sedimentation Rate", "15", "mm/hr", "0", "20"),
        create_lab_test("ESR", "15", "mm/hr", "0", "20")
      ]

      results = instance.format_lab_results(tests)
      expect(results['Peripheral Smear Examination']).to be_present
      expect(results['Peripheral Smear Examination'].length).to eq(6)
    end

    it "correctly categorizes Biochemistry tests" do
      tests = [
        create_lab_test("HbA1c (Glycosylated Hemoglobin)", "5.5", "%", "4.0", "5.6"),
        create_lab_test("Mean Blood Glucose", "120", "mg/dL", "70", "130"),
        create_lab_test("Microalbumin (per urine volume)", "15", "mg/L", "0", "20"),
        create_lab_test("Creatinine, Serum", "0.9", "mg/dL", "0.6", "1.2"),
        create_lab_test("SGPT", "30", "U/L", "0", "40"),
        create_lab_test("SGOT", "25", "U/L", "0", "40")
      ]

      results = instance.format_lab_results(tests)
      expect(results['Biochemistry']).to be_present
      expect(results['Biochemistry'].map { |t| t[:name] }).to include(
        'HbA1c', 'Mean Blood Glucose', 'Microalbumin', 'Creatinine, Serum', 
        'SGPT', 'SGOT'
      )
    end

    it "correctly handles tests with parentheses" do
      tests = [
        create_lab_test("Total Iron Binding Capacity (TIBC)", "300", "µg/dL", "250", "450"),
        create_lab_test("25(OH) Vitamin D", "30", "ng/mL", "20", "50"),
        create_lab_test("HbA1c (Glycosylated Hemoglobin)", "5.5", "%", "4.0", "5.6")
      ]

      results = instance.format_lab_results(tests)
      expect(results['Iron Studies']).to be_present
      expect(results['Immunoassay']).to be_present
      expect(results['Biochemistry']).to be_present
    end

    it "correctly categorizes Thyroid Function Test" do
      tests = [
        create_lab_test("T3 - Triiodothyronine", "1.01", "ng/mL", "0.58", "1.59"),
        create_lab_test("T4 - Thyroxine", "7.84", "µg/dL", "4.87", "11.72"),
        create_lab_test("TSH - Thyroid Stimulating Hormone", "2.54", "µIU/mL", "0.35", "4.94")
      ]

      results = instance.format_lab_results(tests)
      expect(results['Thyroid Function Test']).to be_present
      expect(results['Thyroid Function Test'].length).to eq(3)
      expect(results['Thyroid Function Test'].map { |t| t[:name] }).to match_array([
        'T3 - Triiodothyronine',
        'T4 - Thyroxine',
        'TSH - Thyroid Stimulating Hormone'
      ])
    end

    it "correctly categorizes Protein tests" do
      tests = [
        create_lab_test("Total Protein", "7.2", "g/dL", "6.4", "8.2"),
        create_lab_test("Albumin", "4.5", "g/dL", "3.5", "5.2"),
        create_lab_test("Globulin", "2.7", "g/dL", "2.3", "3.5"),
        create_lab_test("A/G Ratio", "1.67", "ratio", "1.2", "2.2"),
        create_lab_test("Total Bilirubin", "0.8", "mg/dL", "0.3", "1.2"),
        create_lab_test("Conjugated Bilirubin", "0.2", "mg/dL", "0.0", "0.3"),
        create_lab_test("Unconjugated Bilirubin", "0.6", "mg/dL", "0.2", "0.9"),
        create_lab_test("Delta Bilirubin", "0.1", "mg/dL", "0.0", "0.2")
      ]

      results = instance.format_lab_results(tests)
      expect(results['Protein']).to be_present
      expect(results['Protein'].length).to eq(8)
      expect(results['Protein'].map { |t| t[:name] }).to match_array([
        'Total Protein',
        'Albumin',
        'Globulin',
        'A/G Ratio',
        'Total Bilirubin',
        'Conjugated Bilirubin',
        'Unconjugated Bilirubin',
        'Delta Bilirubin'
      ])
    end
  end
end 