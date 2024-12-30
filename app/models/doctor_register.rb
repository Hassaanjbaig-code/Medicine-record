class DoctorRegister < ApplicationRecord
  belongs_to :user
  has_many :qualifications, dependent: :destroy
  has_many :clinics, dependent: :destroy
  has_many :avaliabilities, dependent: :destroy
  has_many :appointment_registers, dependent: :destroy
end
