class CreateSpecializations < ActiveRecord::Migration[7.1]
  def change
    create_table :specializations do |t|
      t.string :name
      t.string :lincense

      t.timestamps
    end
  end
end
