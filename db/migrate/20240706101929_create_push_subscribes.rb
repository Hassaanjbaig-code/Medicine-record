class CreatePushSubscribes < ActiveRecord::Migration[7.1]
  def change
    create_table :push_subscribes do |t|
      t.string :endpoint
      t.string :string
      t.string :p256db
      t.string :auth
      t.boolean :subscribed

      t.timestamps
    end
  end
end
