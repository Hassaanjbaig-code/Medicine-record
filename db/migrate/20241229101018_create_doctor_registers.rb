class CreateDoctorRegisters < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_registers do |t|
      t.string :First_name
      t.string :Last_name
      t.date :date_of_birth
      t.text :gender
      t.string :email
      t.date :practicing_from
      t.string :specialization
      t.references :users, null: false, foreign_key:  true

      t.timestamps
    end
  end
end
