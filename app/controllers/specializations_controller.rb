class SpecializationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor_register, only: [:new, :create]
  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = @doctor.specializations.new(specialization_params)

    issue_date_date = params[:specialization][:issue_date_day]
    issue_date_month = params[:specialization][:issue_date_month]
    issue_date_year = params[:specialization][:issue_date_year]
    expire_date_date = params[:specialization][:expire_date_day]
    expire_date_month = params[:specialization][:expire_date_month]
    expire_date_year = params[:specialization][:expire_date_year]

    if issue_date_date && issue_date_month && issue_date_year && expire_date_date && expire_date_month && expire_date_year
      specialization_issue_date = issue_date_date + "-" + issue_date_month + "-" + issue_date_year
      specialization_expire_date = expire_date_date + "-" + expire_date_month + "-" + expire_date_year
    else
      flash[:error] = "Please provide complete date information."
      render :new and return
    end
    combine_issue_date = Date.parse(specialization_issue_date)
    combine_expire_date = Date.parse(specialization_expire_date)
    @specialization.issue_date = combine_issue_date
    @specialization.expire_date = combine_expire_date

    
    respond_to do |format|
      if @specialization.save
        format.turbo_stream
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
