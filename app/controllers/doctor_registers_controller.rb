class DoctorRegistersController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_doctor

  def index
    @doctor_register = DoctorRegister.all
  end

  def show
    @doctor_register = DoctorRegister.find_by_id(params[:id])
    @appointments = current_user.appointment_registers

    @room = Room.find_by(doctor_register_id: params[:id], patient_id: current_user.patient.id)
    @message = @room.present? ? @room.messages.order(:created_at) : []
  end
  def new
    @doctor = DoctorRegister.new
  end

  def create
    @doctor = current_user.create_doctor_register(doctor_register_params)

    respond_to do |format|
      if @doctor.save!
        format.turbo_stream
        format.html { redirect_to doctor_registers_path, notice: "Doctor was successfully register." }
        format.json { render :show, status: :created, location: @doctor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def doctor_register_params
    params.require(:doctor_register).permit(:First_name, :Last_name, :date_of_birth, :gender, :practicing_from )
  end
end
