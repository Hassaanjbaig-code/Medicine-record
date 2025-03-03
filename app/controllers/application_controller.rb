class ApplicationController < ActionController::Base
  around_action :set_time_zone, if: :current_user
  before_action :check_fill, if: :current_user
  # before_action :check_doctor, if: :current_user

  def check_fill
    if current_user.doctor
      unless current_user.doctor_register
        redirect_to new_doctor_register_path and return
      end
      unless current_user.doctor_register.qualifications
        redirect_to new_doctor_register_qualification_path(current_user.doctor_register) and return
      end
      unless current_user.doctor_register.clinics
        redirect_to new_doctor_register_clinic_path(current_user.doctor_register) and return
      end
      unless current_user.doctor_register.availabilities
        redirect_to new_doctor_register_availability_path(current_user.doctor_register) and return
      end
      unless current_user.doctor_register.specializations
        redirect_to new_doctor_register_specialization_path(current_user.doctor_register) and return
      end
    end
  end

  private
  def set_time_zone
    if current_user.time_zone
      Time.use_zone(current_user.time_zone) { yield }
    # Time.zone = current_user.time_zone
    end
  end
end
