require 'cloudinary'
class MedicinesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medicine, only: %i[ show edit update destroy ]
  before_action :check_cloudinary, only: [:edit, :new]
  include ImageUploadDeleteHelper

  # GET /medicines or /medicines.json
  def index
    # @medicines = Medicine.order(created_at: :desc)
    @medicines = current_user.medicines.where(completed: false)
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
    p @medicine
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

    def cloudinary_delete id
      begin
        image_delete = Cloudinary::Api.delete_resources id
        return image_delete
      rescue => e
        Rails.logger.error "Error for deleteing image: #{e.message}"
      end

    end

    # def upload image
    #   begin
    #     # Check if the image param is present and valid
    #     # raise "No image file present" if image.nil?

    #     # Perform the Cloudinary upload
    #     image_upload = Cloudinary::Uploader.upload(image.path,
    #     :tag => "basic_sample",
    #     :use_filename => true,
    #     :folder => "Medicine_App"
    #     )

    #     # Ensure you're using `.path` to get the file path
    #     return image_upload
    #   rescue => e
    #     Rails.logger.error "Error uploading image: #{e.message}"
    #     return nil
    #   end
    # end

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
