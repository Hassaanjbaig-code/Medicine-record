class AddReferenceToPushSubscribe < ActiveRecord::Migration[7.1]
  def change
    add_reference :push_subscribes, :user, null: false, foreign_key: true
  end
end
