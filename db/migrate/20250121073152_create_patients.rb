class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.string :full_name
      t.string :email
      t.integer :phone_number
      t.date :date_of_birth
      t.string :gender
      t.text :medicinal_history
      t.references :user, null: :false, foreign_key: true
      t.timestamps
    end
  end
end
