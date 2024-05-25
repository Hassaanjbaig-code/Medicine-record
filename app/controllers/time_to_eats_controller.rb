class TimeToEatsController < ApplicationController
  before_action :set_time_to_eat, only: %i[ show edit update destroy ]

  # GET /time_to_eats or /time_to_eats.json
  def index
    @time_to_eats = TimeToEat.all
  end

  # GET /time_to_eats/1 or /time_to_eats/1.json
  def show
  end

  # GET /time_to_eats/new
  def new
    @time_to_eat = TimeToEat.new
  end

  # GET /time_to_eats/1/edit
  def edit
  end

  # POST /time_to_eats or /time_to_eats.json
  def create
    @time_to_eat = TimeToEat.new(time_to_eat_params)

    respond_to do |format|
      if @time_to_eat.save
        format.html { redirect_to time_to_eat_url(@time_to_eat), notice: "Time to eat was successfully created." }
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
      params.require(:time_to_eat).permit(:time_to_eat, :medicine_id)
    end
end
