class QualificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor_register, only: %i[new create]

  def new
    @qualification = @doctor.qualifications.new
  end

  def create
    Rails.logger.debug "Parameters for qualification: #{params[:doctor_register_id]}"

    @doctor_register = DoctorRegister.find_by_id(params[:doctor_register_id])

    # Handle case where @doctor_register is nil
    # unless @doctor_register
    #   respond_to do |format|
    #     format.html { redirect_to medicines_path, alert: "Doctor not found." }
    #   end
    #   return
    # end
    if @doctor_register.update(qualifications_params)
      redirect_to medicines_path
    else
      redirect_to root_path
    end

    # respond_to do |format|
    #     puts "Pass"
    #     format.turbo_stream
    #     format.html { redirect_to medicines_path, notice: "Doctor was successfully registered." }
    #     format.turbo_stream { render turbo_stream: turbo_stream.replace("form_errors", partial: "shared/errors", locals: { errors: @doctor_register.errors }) }
    #     format.html { render :new, status: :unprocessable_entity }
    #   end
  end


  private

  def set_doctor_register
    @doctor = current_user.doctor_register
  end

  # use for the nested Form
  def qualifications_params
    params.require(:doctor_register).permit(qualifications_attributes: [:id, :qualification_name, :institute_name, :procurement_year, :_destroy])
  end
end
