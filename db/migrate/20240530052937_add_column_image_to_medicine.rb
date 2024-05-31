class AddColumnImageToMedicine < ActiveRecord::Migration[7.1]
  def change
    add_column :medicines, :image, :string
  end
end
