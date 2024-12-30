class RenameUsersIdToUserId < ActiveRecord::Migration[7.1]
  def change
    rename_column :appointment_registers, :users_id, :user_id
    rename_column :availabilities, :users_id, :user_id
    rename_column :doctor_registers, :users_id, :user_id
  end
end
