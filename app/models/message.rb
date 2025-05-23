class Message < ApplicationRecord
  belongs_to :room
  # That this line is use to broadcasts all the thing like update destroy every thing
  # broadcasts_to ->(message) { :message_list }
  # Only we wanted to append we write this
  # after_create_commit { broadcast_append_to :message_list }


  # after_create_commit :broadcast_create

  after_create_commit do
    broadcast_append_to :message_list, target: "#{self.room.id}_message" , partial: "messages/message", locals: { message: self }
  end
  # def broadcast_create
  #   broadcast_append_to room,
  #     partial: "messages/message",
  #     locals: { message: self },
  #     target: "message_list"
  # end
end
