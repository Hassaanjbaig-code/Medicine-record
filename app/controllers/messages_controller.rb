class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    Rails.logger.info "params are: #{params.inspect}"
    @room = Room.where(doctor_register_id: params_message[:doctor_register_id], patient_id: params_message[:patient_id])
    print "This is the room finding", @room.count == 0

    # Create a new message in the found room
    @message = @room.first.messages.build(content: params[:content])
    @message.save
    # respond_to do |format|
    #   if @message.save
    #     flash[:success] = "Message sent successfully."
    #     format.turbo_stream { render turbo_stream: turbo_stream.append('message_list', partial: 'messages/message', locals: { message: @message }) }
    #   else
    #     flash[:error] = "Failed to send message."
    #     format.html { redirect_to room_path(@room) } # Adjust the redirect path as needed
    #   end
    # end
  end

  private

  def params_message
    params.require(:messages).permit(:content, :doctor_register_id, :patient_id)
  end
end
