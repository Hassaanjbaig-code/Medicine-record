require 'cloudinary'
class MedicinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medicine, only: %i[ show edit update destroy ]
  before_action :check_in, only: %i[ index complete ]
  before_action :check_cloudinary, only: [:edit, :new]
  include ImageUploadDeleteHelper

  # GET /medicines or /medicines.json
  def index
    @medicines = current_user.medicines.left_joins(:start_end_medicines).select('medicines.*, start_end_medicines.start_time, start_end_medicines.end_time').where(start_end_medicines: { everyday: nil })
    # @medicines = Medicine.joins(:start_end_medicines)
  end

  # GET /medicines/1 or /medicines/1.json
  def show
    @time_to_eats= @medicine.time_to_eats
  end

  # GET /medicines/new
  def new
    @medicine = current_user.medicines.new
  end

  # GET /medicines/1/edit
  def edit
  end

  def complete
    @medicines = current_user.medicines.where(completed: true)
    render :index
  end

  # POST /medicines or /medicines.json
  def create
    image = medicine_params[:image]

    store = upload image
    public_id = store["public_id"]
    image_url = store["url"]
    @medicine = current_user.medicines.new(medicine_params)
    @medicine.public_id = public_id
    @medicine.image = image_url
    respond_to do |format|
      if @medicine.save
        format.turbo_stream
        format.html { redirect_to new_medicine_start_end_medicine_path(@medicine.id), notice: "Medicine was successfully created." }
        format.json { render :show, status: :created, location: @medicine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicines/1 or /medicines/1.json
  def update
    respond_to do |format|
      if @medicine.update(medicine_params)
        format.html { redirect_to medicine_url(@medicine), notice: "Medicine was successfully updated." }
        format.json { render :show, status: :ok, location: @medicine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicines/1 or /medicines/1.json
  def destroy
    id = @medicine.public_id
    cloudinary_delete id
    @medicine.destroy!

    respond_to do |format|
      format.html { redirect_to medicines_url, notice: "Medicine was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medicine
      @medicine = Medicine.find(params[:id])
    end

    def check_in
      puts "This function check doctor", current_user.doctor
      # If the current user is not a doctor
      if current_user.doctor.nil? || current_user.doctor == false
        puts "This will check if the current user's patient is nil", current_user.patient.nil?
        if current_user.patient.nil?
          redirect_to new_patient_path and return
        end
      # If the current user is a doctor
      elsif current_user.doctor == true
        if current_user.doctor_register.nil?
          redirect_to new_doctor_register_path and return
        else
          redirect_to doctor_appointment_index_path and return
        end
      end
    end

    def cloudinary_delete id
      begin
        image_delete = Cloudinary::Api.delete_resources id
        return image_delete
      rescue => e
        Rails.logger.error "Error for deleteing image: #{e.message}"
      end

    end

    def config_cloudinary
      Cloudinary.config_from_url("#{ENV["URL"]}")
      Cloudinary.config do |config|
        config.secure = true
      end
    end
    def check_cloudinary
      render '_cloudinary_missing' if Cloudinary.config.api_key.blank?
      # CLOUDINARY_URL=cloudinary://178121197876222:aDIsdSBMaaLmkagYo8wAqq4kGWE@dgimwjugr
    end

    # Only allow a list of trusted parameters through.
    def medicine_params
      params.require(:medicine).permit(:medicine_name, :use_for, :medicine_mg, :image)
    end
end
