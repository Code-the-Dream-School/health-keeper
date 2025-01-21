# frozen_string_literal: true

FactoryBot.define do
  factory :health_record do
    user
    notes { 'Morning blood test' }

    after(:build) do |health_record|
      # Create a PDF with a file attachment if one doesn't exist
      if health_record.pdfs.empty?
        pdf = build(:pdf, health_record: health_record)
        pdf_content = StringIO.new("%PDF-1.4\n1 0 obj\n<</Type /Catalog>>\nendobj\ntrailer\n<</Root 1 0 R>>\n%%EOF")
        pdf.file.attach(
          io: pdf_content,
          filename: 'test_lab_report.pdf',
          content_type: 'application/pdf'
        )
        pdf.save!
      end
    end
  end
end
