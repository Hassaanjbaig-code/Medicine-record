class StartEndMedicinesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_medicine
  before_action :set_start_end_medicine, only: %i[ show edit update destroy ]

  def index
    @start_end_medicines = @medicine.start_end_medicines
  end


  # GET /start_end_medicines/1 or /start_end_medicines/1.json
  def show
  end

  # GET /start_end_medicines/new
  def new
    @medicine_start_end_medicines = @medicine.start_end_medicines.build
  end

  # GET /start_end_medicines/1/edit
  def edit
  end

  # POST /start_end_medicines or /start_end_medicines.json
  def create
    # medicine_start_end_medicines = StartEndMedicine.new(start_end_medicine_params)
    # medicine_start_end_medicines.medicine_id = @medicine.id
    @medicine_start_end_medicines = @medicine.start_end_medicines.build(start_end_medicine_params)

    respond_to do |format|
      if @medicine_start_end_medicines.save
        format.turbo_stream
        format.html { redirect_to new_medicine_time_to_eat_path(@medicine), notice: "Start end medicine was successfully created." }
        format.json { render :show, status: :created, location: @medicine_start_end_medicines }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medicine_start_end_medicines.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /start_end_medicines/1 or /start_end_medicines/1.json
  def update
    respond_to do |format|
      if @start_end_medicine.update(start_end_medicine_params)
        format.html { redirect_to start_end_medicine_url(@start_end_medicine), notice: "Start end medicine was successfully updated." }
        format.json { render :show, status: :ok, location: @start_end_medicine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @start_end_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /start_end_medicines/1 or /start_end_medicines/1.json
  def destroy
    @start_end_medicine.destroy!

    respond_to do |format|
      format.html { redirect_to [@medicine, :start_end_medicine], notice: "Start end medicine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  #  for finding the medicine
    def find_medicine
      @medicine = Medicine.find(params[:medicine_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_start_end_medicine

      @start_end_medicine = StartEndMedicine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def start_end_medicine_params
      params.require(:start_end_medicine).permit(:start_date, :end_date, :everyday)
    end
end
