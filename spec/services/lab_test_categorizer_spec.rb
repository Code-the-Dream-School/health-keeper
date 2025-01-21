require 'rails_helper'

RSpec.describe LabTestCategorizer do
  include LabTestCategorizationHelper

  # Shared context
  shared_context "with logger setup" do
    let(:logger) { instance_double("ActiveSupport::Logger") }

    before do
      allow(Rails).to receive(:logger).and_return(logger)
      allow(logger).to receive(:debug)
      allow(logger).to receive(:error)
    end
  end

  # Shared examples for categories
  shared_examples "verifies category tests" do |category, test_data|
    it "correctly categorizes #{category} tests" do
      results = described_class.categorize(tests)
      expect(results[category]).to be_present
      expect(results[category].map { |t| t[:name] }).to match_array(expected_test_names)
    end
  end

  describe '.categorize' do
    include_context "with logger setup"

    let(:reference_range) { { min: "0", max: "100" } }

    # Helper method to create multiple tests
    def create_test_batch(test_configs)
      test_configs.map do |config|
        create_lab_test(
          name: config[:name],
          value: config[:value] || "100",
          unit: config[:unit] || "mg/dL",
          min_value: config[:min] || reference_range[:min],
          max_value: config[:max] || reference_range[:max],
          notes: config[:notes]
        )
      end
    end

    context "with invalid input" do
      it "returns empty hash for nil input" do
        expect(described_class.categorize(nil)).to eq({})
      end

      it "returns empty hash for empty array" do
        expect(described_class.categorize([])).to eq({})
      end

      it "returns empty hash for invalid test data" do
        invalid_test = double(biomarker: nil)
        expect(described_class.categorize([invalid_test])).to eq({})
      end
    end

    context "with Differential Count tests" do
      let(:tests) do
        create_test_batch([
          # Percentage values
          { name: 'Neutrophils', value: '62', unit: '%', min: '40', max: '80', notes: 'Manual Count' },
          { name: 'Lymphocytes', value: '30', unit: '%', min: '20', max: '40', notes: 'Manual Count' },
          { name: 'Eosinophils', value: '2', unit: '%', min: '1', max: '6', notes: 'Manual Count' },
          { name: 'Monocytes', value: '5', unit: '%', min: '2', max: '10', notes: 'Manual Count' },
          { name: 'Basophils', value: '1', unit: '%', min: '0', max: '2', notes: 'Manual Count' },
          # Absolute counts
          { name: 'Neutrophils Absolute', value: '4200', unit: '/µL', min: '2000', max: '7000', notes: 'Calculated' },
          { name: 'Lymphocytes Absolute', value: '2100', unit: '/µL', min: '1000', max: '3000', notes: 'Calculated' },
          { name: 'Eosinophils Absolute', value: '140', unit: '/µL', min: '20', max: '500', notes: 'Calculated' },
          { name: 'Monocytes Absolute', value: '350', unit: '/µL', min: '200', max: '800', notes: 'Calculated' },
          { name: 'Basophils Absolute', value: '70', unit: '/µL', min: '20', max: '100', notes: 'Calculated' },
          # Other counts
          { name: 'Platelet Count', value: '250000', unit: '/cmm', min: '150000', max: '450000', notes: 'Automated' },
          { name: 'MPV', value: '10', unit: 'fL', min: '7.4', max: '10.4', notes: 'Automated' }
        ])
      end

      let(:expected_test_names) do
        [
          'Neutrophils', 'Lymphocytes', 'Eosinophils', 'Monocytes', 'Basophils',
          'Neutrophils Absolute', 'Lymphocytes Absolute', 'Eosinophils Absolute', 'Monocytes Absolute', 'Basophils Absolute',
          'Platelet Count', 'MPV'
        ]
      end

      include_examples "verifies category tests", "Differential Count"

      it "includes method information for each test" do
        results = described_class.categorize(tests)
        differential_count = results["Differential Count"]

        # Check percentage tests have Manual Count method
        %w[Neutrophils Lymphocytes Eosinophils Monocytes Basophils].each do |test_name|
          test = differential_count.find { |t| t[:name] == test_name }
          expect(test[:method]).to eq('Manual Count')
        end

        # Check absolute counts have Calculated method
        %w[Neutrophils Lymphocytes Eosinophils Monocytes Basophils].each do |base_name|
          test = differential_count.find { |t| t[:name] == "#{base_name} Absolute" }
          expect(test[:method]).to eq('Calculated')
        end

        # Check other counts have Automated method
        ['Platelet Count', 'MPV'].each do |test_name|
          test = differential_count.find { |t| t[:name] == test_name }
          expect(test[:method]).to eq('Automated')
        end
      end
    end

    context "with Biochemistry tests" do
      let(:tests) do
        create_test_batch([
          { name: 'Total Protein', value: '7.2', unit: 'g/dL', min: '6.4', max: '8.2' },
          { name: 'Albumin', value: '4.5', unit: 'g/dL', min: '3.5', max: '5.2' },
          { name: 'Globulin', value: '2.7', unit: 'g/dL', min: '2.3', max: '3.5' }
        ])
      end

      let(:expected_test_names) do
        ['Total Protein', 'Albumin', 'Globulin']
      end

      include_examples "verifies category tests", "Protein"
    end

    context "with test methods in notes" do
      it "correctly processes method names from notes" do
        test = create_lab_test(
          name: 'Hemoglobin',
          value: '14.5',
          unit: 'g/dL',
          min_value: 13.0,
          max_value: 17.0,
          notes: 'Colorimetric'
        )

        result = described_class.categorize([test])
        expect(result['Complete Blood Count'].first[:name]).to eq('Hemoglobin')
        expect(result['Complete Blood Count'].first[:method]).to eq('Colorimetric')
      end
    end

    context "with special case matches" do
      it "correctly matches special cases" do
        test = create_lab_test(
          name: 'Sugar',
          value: '100',
          unit: 'mg/dL',
          min_value: 70,
          max_value: 110
        )

        result = described_class.categorize([test])
        expect(result['Biochemistry'].first[:name]).to eq('Sugar')
      end
    end

    context "with error handling" do
      it "logs errors for unmatched tests" do
        tests = create_test_batch([
          { name: 'Unknown Test 1', value: '100', unit: 'mg/dL', min: '0', max: '100' },
          { name: 'Unknown Test 2', value: '200', unit: 'mg/dL', min: '0', max: '200' }
        ])

        described_class.categorize(tests)

        expect(logger).to have_received(:error).with(/Could not categorize test: Unknown Test 1/).once
        expect(logger).to have_received(:error).with(/Could not categorize test: Unknown Test 2/).once
      end
    end
  end
end