class AppointmentRegistersController < ApplicationController
  before_action :authenticate_user!
  include DoctorRegistersHelper

  def create
    @doctor = DoctorRegister.find_by_id(params[:doctor_register_id])

    appointment_time = Time.zone.local(
      params[:doctor_register]["appointment(1i)"].to_i,
      params[:doctor_register]["appointment(2i)"].to_i,
      params[:doctor_register]["appointment(3i)"].to_i,
      params[:doctor_register]["appointment(4i)"].to_i,
      params[:doctor_register]["appointment(5i)"].to_i
    )

    if @doctor.nil?
      redirect_to doctor_register_path(@doctor), alert: "Doctor not found." and return
    end

    if @doctor.user_id == current_user.id
      redirect_to doctor_register_path(@doctor), alert: "Same user cannot create an appointment." and return
    end
    if check_availabilities @doctor, appointment_time
      redirect_to doctor_register_path(@doctor), alert: "Doctor is not avaliable in this date" and return
    end

    @appointment_registers = current_user.appointment_registers.new(appointment_params)
    @appointment_registers.status = false
    @appointment_registers.doctor_register_id = @doctor.id

    if @appointment_registers.save
      redirect_to doctor_register_path(@doctor), notice: "Appointment is added."
    else
      render :new, status: :unprocessable_entity, alert: "Appointment not created."
    end
  end

  private
  def appointment_params
    params.require(:doctor_register).permit(:appointment)
  end
end
