class CreateQualifications < ActiveRecord::Migration[7.1]
  def change
    create_table :qualifications do |t|
      t.string :qualification_name, null: false
      t.string :institute_name, null: false
      t.integer :procurement_year
      t.references :doctor_registers, null: false, foreign_key: true

      t.timestamps
    end
  end
end
