module LabTestCategorizationHelper
  def create_lab_test(name:, value:, unit:, min_value: nil, max_value: nil, notes: nil)
    biomarker = if name.start_with?('Unknown Test')
                  create(:biomarker, name: name)
                else
                  create(:biomarker, name: name)
                end

    reference_range = if min_value && max_value
                       create(:reference_range, min_value: min_value, max_value: max_value, unit: unit)
                     else
                       case name
                       when 'Glucose' then create(:reference_range, :for_glucose)
                       when 'Hemoglobin' then create(:reference_range, :for_hemoglobin)
                       when 'Cholesterol' then create(:reference_range, :for_cholesterol)
                       when /Neutrophils|Lymphocytes|Eosinophils|Monocytes|Basophils/
                         create(:reference_range, :for_differential_count)
                       else
                         create(:reference_range, unit: unit)
                       end
                     end

    health_record = create(:health_record)
    pdf = build(:pdf, health_record: health_record)
    pdf_content = StringIO.new("%PDF-1.4\n1 0 obj\n<</Type /Catalog>>\nendobj\ntrailer\n<</Root 1 0 R>>\n%%EOF")
    pdf.file.attach(io: pdf_content, filename: 'test_lab_report.pdf', content_type: 'application/pdf')
    pdf.save!

    create(:lab_test,
           biomarker: biomarker,
           reference_range: reference_range,
           value: value,
           unit: unit,
           notes: notes,
           pdf: pdf,
           recordable: health_record)
  end
end 