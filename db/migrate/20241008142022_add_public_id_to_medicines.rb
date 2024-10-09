class AddPublicIdToMedicines < ActiveRecord::Migration[7.1]
  def change
    add_column :medicines, :public_id, :string
  end
end
