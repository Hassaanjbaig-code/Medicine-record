class SpecializationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor_register, only: [:new, :create]
  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = @doctor.specializations.new(specialization_params)

    respond_to do |format|
      if @specialization.save
        format.html { redirect_to root_path, notice: "Specialization is created" }
        format.json { render :new, status: :created, location: @specialization }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_doctor_register
    @doctor = current_user.doctor_register
  end

  def specialization_params
    params.require(:specialization).permit(:name, :license, :issuing_authority, :issue_date, :expire_date)
  end
end
