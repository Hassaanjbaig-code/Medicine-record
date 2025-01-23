class RenameRoomIdToRoomId < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :rooms_id, :room_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
