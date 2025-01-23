class UpdateRoomsForPatientsReference < ActiveRecord::Migration[7.1]
  def change
    remove_column :rooms, :user_id, :integer
    add_reference :rooms, :patient, null: false, foreign_key: true
  end
end
