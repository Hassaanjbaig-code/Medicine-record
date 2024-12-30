class CreateClinics < ActiveRecord::Migration[7.1]
  def change
    create_table :clinics do |t|
      t.string :clinic_name, null: false
      t.string :address
      t.integer :contact_number
      t.references :doctor_registers, null: false, foreign_key: true

      t.timestamps
    end
  end
end
