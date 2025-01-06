class DoctorRegistersController < ApplicationController
  before_action :authenticate_user!

  def index

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
    params.require(:doctor_register).permit(:First_name, :Last_name, :date_of_birth, :gender, :practicing_from, :specialization)
  end
end
