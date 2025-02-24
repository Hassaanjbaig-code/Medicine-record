class ClinicsController < ApplicationController
  before_action :set_doctor_register, only: %i[new create]

  def new
    @clinic = @doctor.clinics.new
  end

  def create
    @doctor_register = DoctorRegister.find_by_id(params[:doctor_register_id])
    respond_to do |format|
      if @doctor_register.update(clinics_params)
        format.turbo_stream
        format.html { redirect_to root_path, notice: "Clinic is Created" }
        format.json { render :new, status: :created, location: @doctor }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_doctor_register
    @doctor = current_user.doctor_register
  end

  def clinics_params
    params.require(:doctor_register).permit(clinics_attributes: [:clinic_name, :address, :contact_number])
  end
end
