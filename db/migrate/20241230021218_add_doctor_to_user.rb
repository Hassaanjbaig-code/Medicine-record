class AddDoctorToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :doctor, :boolean
  end
end
