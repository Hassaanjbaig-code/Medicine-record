class RenameAppointmentstoappointmentInappointments < ActiveRecord::Migration[7.1]
  def change
    rename_column :appointments, :Appointments, :appointment
    rename_column :appointments, :Status, :status
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
