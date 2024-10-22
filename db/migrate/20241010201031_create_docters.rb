class CreateDocters < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :Fullname
      t.string :Specialty
      t.string :Email
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
