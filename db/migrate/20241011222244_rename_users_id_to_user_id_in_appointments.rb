class RenameUsersIdToUserIdInAppointments < ActiveRecord::Migration[7.1]
  def change
    rename_column :appointments, :users_id, :user_id
    rename_column :appointments, :doctors_id, :doctor_id
  end
end
