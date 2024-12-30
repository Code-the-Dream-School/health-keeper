class CreatePdfs < ActiveRecord::Migration[7.1]
  def change
    create_table :pdfs do |t|
      t.string :title
      t.string :template_type
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end 