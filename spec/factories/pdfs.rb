# frozen_string_literal: true

FactoryBot.define do
  factory :pdf do
    association :user
    association :health_record
    scan_method { 'sterling_accuris' }
    status { 'pending' }
    processed_data { {} }
    notes { 'Test lab report' }

    after(:build) do |pdf|
      if !pdf.file.attached?
        pdf_content = StringIO.new("%PDF-1.4\n1 0 obj\n<</Type /Catalog>>\nendobj\ntrailer\n<</Root 1 0 R>>\n%%EOF")
        pdf.file.attach(
          io: pdf_content,
          filename: 'test_lab_report.pdf',
          content_type: 'application/pdf'
        )
      end
    end
  end
end 