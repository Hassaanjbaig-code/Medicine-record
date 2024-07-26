class AddReferenceToTimetoeat < ActiveRecord::Migration[7.1]
  def change
    add_reference :time_to_eats, :user, foreign_key: true
  end
end
