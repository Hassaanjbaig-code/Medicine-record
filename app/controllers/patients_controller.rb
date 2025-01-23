class PatientsController < ApplicationController
  before_action :authenticate_user!
  def new
    @patients = Patient.new
  end

  def create
    @patients = current_user.create_patient(patient_params)
    @patients.email = current_user.email

    respond_to do |format|
      if @patients.save!
        format.html { redirect_to root_path, notice: "Patient was successfully register." }
        format.json { render :show, status: :created, location: @patients }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patients.errors, status: :unprocessable_entity, alert: "Fill form correctly" }
      end
    end
  end

  def show
    @patient = Patient.find_by_id params[:id]
    @user = @patient.user
    @appointments = current_user.doctor_register.appointment_registers.where(user_id: @user.id)
    @room = Room.find_by(doctor_register_id: current_user.doctor_register.id, patient_id: params[:id])
    @message = @room&.messages
  end

  private
  def patient_params
    params.require(:patient).permit(:full_name, :phone_number, :date_of_birth, :gender, :medicinal_history)
  end
end
