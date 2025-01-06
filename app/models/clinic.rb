class Clinic < ApplicationRecord
  belongs_to :doctor_register
  geocoded_by :address
  after_validation validation_method, on: :create
end
