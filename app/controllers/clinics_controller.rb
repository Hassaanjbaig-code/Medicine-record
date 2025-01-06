class ClinicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor_register, only: %i[new create]
  def new
    @clinic = @doctor.clinics.new
  end

  def create
    
  end

  private
  def set_doctor_register
    @doctor = current_user.doctor_register
  end
  def clinics_params
    param.require(:doctor_register).permit(clinics_attributes: [:clinic_name, :address, :contact_number])

  end
end
