class RenameDoctorRegistersIdToDoctorRegisterIdInQualifications < ActiveRecord::Migration[7.1]
  def change
    rename_column :qualifications, :doctor_registers_id, :doctor_register_id
  end
end
