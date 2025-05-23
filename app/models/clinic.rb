class Clinic < ApplicationRecord
  belongs_to :doctor_register
  geocoded_by :address

  validates :clinic_name, presence: true
  validates :address, presence: true
  validates :contact_number, presence: true
  # after_validation validation_method, on: :create
end
