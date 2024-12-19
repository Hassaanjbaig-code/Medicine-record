class Api::V1::AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @doctor = current_user.doctors.find(params[:doctor_id])
    @appointment = @doctor.appointment.new
  end

  def create
    @doctor = current_user.doctors.find(params[:doctor_id])

    # Convert the status to boolean
    sanitized_params = appointment_params
    sanitized_params[:status] = ActiveModel::Type::Boolean.new.cast(sanitized_params[:status])

    @appointment = @doctor.appointments.build(sanitized_params)
    @appointment.user_id = current_user.id

    respond_to do |format|
      if @appointment.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("appointment", partial: "doctors/doctor", locals: { doctor: @doctor }) }
        format.html { redirect_to @appointment, notice: "Appointment was successfully created." }
        format.json { render :show, status: :created, location: @appointment, message: 'Appointment created' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity, message: 'Appointment not created' }
      end
    end
  end


  def destroy
    @appointment = Appointment.find_by_id(params[:id])
    @appointment.destroy!

    respond_to do |format|
      format.turbo_stream {  render turbo_stream: turbo_stream.remove(@appointment) }
      format.html { redirect_to root_path }
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:appointment, :status)
  end
end
