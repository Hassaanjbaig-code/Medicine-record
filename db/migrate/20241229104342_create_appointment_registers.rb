class CreateAppointmentRegisters < ActiveRecord::Migration[7.1]
  def change
    create_table :appointment_registers do |t|
      t.datetime :appointment
      t.string :status
      t.references :doctor_registers, null: false, foreign_key: true
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
