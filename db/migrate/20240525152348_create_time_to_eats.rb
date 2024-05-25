class CreateTimeToEats < ActiveRecord::Migration[7.1]
  def change
    create_table :time_to_eats do |t|
      t.time :time_to_eat
      t.references :medicine, null: false, foreign_key: true

      t.timestamps
    end
  end
end
