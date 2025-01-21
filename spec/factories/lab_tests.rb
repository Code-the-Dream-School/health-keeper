# frozen_string_literal: true

FactoryBot.define do
  factory :lab_test do
    user
    biomarker
    reference_range
    recordable factory: %i[health_record]
    value { 85.0 }
    unit { 'mg/dL' }
    notes { 'Regular checkup' }
    
    after(:build) do |lab_test|
      # Create a PDF with a file attachment if one doesn't exist
      if lab_test.pdf.nil?
        health_record = lab_test.recordable || create(:health_record)
        lab_test.pdf = create(:pdf, health_record: health_record)
        pdf_content = StringIO.new("%PDF-1.4\n1 0 obj\n<</Type /Catalog>>\nendobj\ntrailer\n<</Root 1 0 R>>\n%%EOF")
        lab_test.pdf.file.attach(
          io: pdf_content,
          filename: 'test_lab_report.pdf',
          content_type: 'application/pdf'
        )
      end
    end
  end
end
