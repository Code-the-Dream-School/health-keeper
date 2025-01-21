class AddPdfIdToLabTests < ActiveRecord::Migration[7.1]
  def change
    add_reference :lab_tests, :pdf, null: false, foreign_key: true
  end
end
