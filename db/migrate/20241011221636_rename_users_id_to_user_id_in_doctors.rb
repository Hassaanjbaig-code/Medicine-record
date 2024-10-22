class RenameUsersIdToUserIdInDoctors < ActiveRecord::Migration[7.1]
  def change
    rename_column :doctors, :users_id, :user_id
  end
end
