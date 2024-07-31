class AddCompletedToMedicines < ActiveRecord::Migration[7.1]
  def change
    add_column :medicines, :completed, :boolean, default: false
  end
end
