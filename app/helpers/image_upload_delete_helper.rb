require 'cloudinary'
module ImageUploadDeleteHelper
  def upload image
    begin
      # Check if the image param is present and valid
      # raise "No image file present" if image.nil?

      # Perform the Cloudinary upload
      image_upload = Cloudinary::Uploader.upload(image.path,
      :tag => "basic_sample",
      :use_filename => true,
      :folder => "Medicine_App"
      )

      # Ensure you're using `.path` to get the file path
      return image_upload
    rescue => e
      Rails.logger.error "Error uploading image: #{e.message}"
      return nil
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

end
