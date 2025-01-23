class DoctorRegister < ApplicationRecord
  belongs_to :user
  has_many :qualifications, dependent: :destroy
  has_many :clinics, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :appointment_registers, dependent: :destroy
  has_many :specializations, dependent: :destroy
  has_many :rooms, dependent: :destroy
  accepts_nested_attributes_for :qualifications, allow_destroy: true
  accepts_nested_attributes_for :clinics, allow_destroy: true
end
