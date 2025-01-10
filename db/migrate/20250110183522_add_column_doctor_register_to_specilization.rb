class AddColumnDoctorRegisterToSpecilization < ActiveRecord::Migration[7.1]
  def change
    add_reference :specializations, :doctor_register, null: false, foreign_key: true
  end
end
