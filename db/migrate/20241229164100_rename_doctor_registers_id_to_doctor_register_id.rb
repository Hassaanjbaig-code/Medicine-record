class RenameDoctorRegistersIdToDoctorRegisterId < ActiveRecord::Migration[7.1]
  def change

    rename_column :appointment_registers, :doctor_registers_id, :doctor_register_id
    rename_column :availabilities, :doctor_registers_id, :doctor_register_id
    rename_column :clinics, :doctor_registers_id, :doctor_register_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
