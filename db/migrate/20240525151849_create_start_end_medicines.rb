class CreateStartEndMedicines < ActiveRecord::Migration[7.1]
  def change
    create_table :start_end_medicines do |t|
      t.date :start_date
      t.date :end_date
      t.boolean :everyday
      t.references :medicine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
