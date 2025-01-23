class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_docter, only: %i[ show edit update destroy ]
  before_action :check_doctor

  # GET /doctors or /doctors.json
  def index
    # @doctors = current_user.doctors.all
    @doctors = current_user.doctors.includes(:appointments).all.order(created_at: :desc)
    # p @doctors[0].appointments
  end

  # GET /doctors/1 or /doctors/1.json
  def show
    @appointment = Appointment.new
  end

  # GET /doctors/new
  def new
    @doctor = current_user.doctors.new
    @appointment = @doctor.appointments.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors or /doctors.json
    def create
      @doctor = current_user.doctors.new(doctor_params)

      respond_to do |format|
        if @doctor.save
          # Create a new appointment associated with the doctor
          @appointment = @doctor.appointments.create(
            appointment: params[:doctor][:appointment],
            status: false,
            user_id: current_user.id
          )

          format.html { redirect_to @doctor, notice: "Doctor and appointment were successfully created." }
          format.json { render :show, status: :created, location: @doctor }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @doctor.errors, status: :unprocessable_entity }
        end
      end
    end

  # PATCH/PUT /doctors/1 or /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        format.html { redirect_to @doctor, notice: "Doctor was successfully updated." }
        format.json { render :show, status: :ok, location: @doctor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1 or /doctors/1.json
  def destroy
    @doctor.destroy!

    respond_to do |format|
      format.html { redirect_to doctors_path, status: :see_other, notice: "Doctor was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_docter
      # @doctor = Doctor.find(params[:id])
      @doctor = current_user.doctors.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:Fullname, :Specialty, :Email)  # Ensure you use the correct column names (capitalized)
    end
end
