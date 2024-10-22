class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments do |t|
      t.datetime :Appointments
      t.boolean :Status
      t.references :users, null: false, foreign_key: true
      t.references :doctors, null: false, foreign_key: true

      t.timestamps
    end
  end
end
