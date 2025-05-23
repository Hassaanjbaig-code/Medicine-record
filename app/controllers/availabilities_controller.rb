class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor_register, only: [:new, :create]

  def new
    @availabilities = @doctor.availabilities.new
  end

  def create
    # Rails.logger.info "Params: #{params.dig(:availability, :day_of_weeks)}"

    # Ensure `day_of_weeks` is an array
    day_of_weeks = params.dig(:availability, :day_of_weeks)
    hour = params[:availability][:available_from_hour]
    minute = params[:availability][:available_from_minute]
    ampm = params[:availability][:available_from_ampm]
    hour_to = params[:availability][:available_to_hour]
    minute_to = params[:availability][:available_to_minute]
    ampm_to = params[:availability][:available_to_ampm]

    if hour.present? && minute.present? && ampm.present? && hour_to.present? && minute_to.present? && ampm_to.present?
      time_string_from = "#{hour}:#{minute} #{ampm}"
      time_string_to = "#{hour_to}:#{minute_to} #{ampm_to}"
      available_from = Time.parse(time_string_from)
      available_to = Time.parse(time_string_to)
    else
      flash[:alert] = "Please select all fields for 'Available From and Available To'."
      redirect_to new_availability_path and return
    end

    day_of_week = day_of_weeks.join.to_i

    result = Availability.create({
      day_of_week: day_of_week,
      available_from: available_from,
      available_to: available_to,
      doctor_register_id: @doctor.id,
      user_id: current_user.id
    })

    if result.save!
      flash[:notice] = "Availabilities created successfully!"
      redirect_to root_path
    else
      flash[:alert] = "Error creating availabilities."
      redirect_to new_doctor_register_availability_path(@doctor)
    end
  end

  private

  def set_doctor_register
    @doctor = current_user.doctor_register
  end

  def availabilities_params
    params.require(:availabilities).permit(:day_of_weeks)
  end
end
