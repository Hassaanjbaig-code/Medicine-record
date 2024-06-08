class TimeToEatsController < ApplicationController
  before_action :set_time_to_eat, only: %i[ show edit update destroy ]

  # GET /time_to_eats or /time_to_eats.json
  def index
    @medicine = Medicine.find(params[:medicine_id])
    @time_to_eats = @medicine.time_to_eat
  end

  # GET /time_to_eats/1 or /time_to_eats/1.json
  def show
  end

  # GET /time_to_eats/new
  def new
    @medicine_id = Medicine.find(params[:medicine_id])
    @time_to_eat = TimeToEat.new
  end

  # GET /time_to_eats/1/edit
  def edit
  end

  # POST /time_to_eats or /time_to_eats.json
  def create
    @medicine_id = Medicine.find(params[:medicine_id])
    @time_to_eat = TimeToEat.new(time_to_eat_params)
    @time_to_eat.medicine_id = @medicine_id.id

    respond_to do |format|
      if @time_to_eat.save
        format.html { redirect_to medicine_time_to_eats_path(@medicine_id), notice: "Time to eat was successfully created." }
        format.json { render :show, status: :created, location: @time_to_eat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @time_to_eat.errors, status: :unprocessable_entity }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_time_to_eat
      @time_to_eat = TimeToEat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def time_to_eat_params
      params.require(:time_to_eat).permit(:time_to_eat)
    end
end
