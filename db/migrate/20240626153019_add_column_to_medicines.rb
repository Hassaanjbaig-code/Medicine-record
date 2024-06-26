class AddColumnToMedicines < ActiveRecord::Migration[7.1]
  def change
    add_reference :medicines, :user, foreign_key: true
  end
end
