class DoctorAppointmentController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:show_message]  # Disable CSRF protection for show_message action

  def index
    @doctor_register = current_user.doctor_register
    @appointment = @doctor_register.appointment_registers
    @appointments = @doctor_register.appointment_registers.map do |appointment|
      OpenStruct.new(start_time: appointment.appointment, user: appointment.user)
    end
  end

  def show_message
    # @message = "This is a custom message for user with ID #{params[:id]}"
    @doctor_register = current_user.doctor_register
    @room = Room.where(user_id: params[:id], doctor_register_id: @doctor_register.id )
    puts "This is the result of the room", @room

    if @room.present?
      @message = @room.first.messages
    else
      flash[:alert] = "Room is not Created"
    end
    respond_to do |format|
      format.js # Renders `show_message.js.erb`
    end
  end
end
