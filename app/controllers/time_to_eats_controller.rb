class TimeToEatsController < ApplicationController
  before_action :authenticate_user!
  before_action :first_medicine
  before_action :set_time_to_eat, only: %i[ show edit update destroy ]

  rescue_from ActiveRecord::RecordNotFound, with: :medicine_not_found

  # GET /time_to_eats or /time_to_eats.json
  def index
    if @medicine.present?
      @time_to_eats = @medicine.time_to_eats
      else
      respond_to do |format|
        format.html { redirect_to medicines_path, notice: "No Medicine Found", status: 404 }
      end
    end
  end


  # GET /time_to_eats/1 or /time_to_eats/1.json
  def show
  end

  # GET /time_to_eats/new
  def new
    @time_to_eat = @medicine.time_to_eats.build
  end

  # GET /time_to_eats/1/edit
  def edit
  end

  # POST /time_to_eats or /time_to_eats.json
  def create
    p "this is the params"
    p medicine_params
    respond_to do |format|
      if @medicine.update(medicine_params)
        format.html { redirect_to medicines_path, notice: "Time to eat was successfully created." }
        format.json { render :show, status: :created, location: @medicine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_to_eats/1 or /time_to_eats/1.json
  def update
    respond_to do |format|
      if @time_to_eat.update(time_to_eat_params)
        format.html { redirect_to time_to_eat_url(@time_to_eat), notice: "Time to eat was successfully updated." }
        format.json { render :show, status: :ok, location: @time_to_eat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @time_to_eat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_to_eats/1 or /time_to_eats/1.json
  def destroy
    @time_to_eat.destroy!

    respond_to do |format|
      format.html { redirect_to time_to_eats_url, notice: "Time to eat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    #If the Medicine not found what will happen
    def medicine_not_found
      redirect_to medicines_path, alert: "No Medicine Found", status: 302
    end
    # Use callbacks to share common setup or constraints between actions.
    def first_medicine
      @medicine = current_user.medicines.find(params[:medicine_id])
    end
    def set_time_to_eat
      @time_to_eat = TimeToEat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_to_eat_params
      params.require(:time_to_eats).permit[:time_to_eats]
    end

    # Use of the nested form
    def medicine_params
      params.require(:medicine).permit(time_to_eats_attributes: [:time_to_eat, :user_id])
    end

end
