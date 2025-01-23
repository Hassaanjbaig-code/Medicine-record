class RemoveUserToMessage < ActiveRecord::Migration[7.1]
  def change
    remove_column :messages, :user_id
    remove_column :messages, :doctor_register_id
    add_reference :messages, :rooms, foreign_key: true
    #Ex:- :null => false

  end
end
