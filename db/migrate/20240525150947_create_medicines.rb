class CreateMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :medicines do |t|
      t.string :medicine_name
      t.string :use_for
      t.integer :medicine_mg

      t.timestamps
    end
  end
end
