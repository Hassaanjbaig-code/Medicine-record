# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_in_path_for(resource)
    if resource.doctor
      if resource.doctor_register.blank?
        new_doctor_register_path
      elsif resource.doctor_register.qualifications.blank?
        new_doctor_register_qualification_path(resource.doctor_register)
      elsif resource.doctor_register.clinics.blank?
        new_doctor_register_clinic_path(resource.doctor_register)
      elsif resource.doctor_register.availabilities.blank?
        new_doctor_register_availability_path(resource.doctor_register)
      elsif resource.doctor_register.specializations.blank?
        new_doctor_register_specialization_path(resource.doctor_register)
      else
        super
      end
    else
      super
    end
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
