class StartEndMedicinesController < ApplicationController
  before_action :set_start_end_medicine, only: %i[ show edit update destroy ]

  def index
    @medicine = Medicine.find(params[:medicine_id])
    @start_end_medicines = @medicine.start_end_medicines
  end


  # GET /start_end_medicines/1 or /start_end_medicines/1.json
  def show
  end

  # GET /start_end_medicines/new
  def new
    @start_end_medicine = StartEndMedicine.new
  end

  # GET /start_end_medicines/1/edit
  def edit
  end

  # POST /start_end_medicines or /start_end_medicines.json
  def create
    @start_end_medicine = StartEndMedicine.new(start_end_medicine_params)

    respond_to do |format|
      if @start_end_medicine.save
        format.html { redirect_to start_end_medicine_url(@start_end_medicine), notice: "Start end medicine was successfully created." }
        format.json { render :show, status: :created, location: @start_end_medicine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @start_end_medicine.errors, status: :unprocessable_entity }
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
      format.html { redirect_to start_end_medicines_url, notice: "Start end medicine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_start_end_medicine
      @start_end_medicine = StartEndMedicine.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def start_end_medicine_params
      params.require(:start_end_medicine).permit(:start_date, :end_date, :everyday, :medicine_id)
    end
end
