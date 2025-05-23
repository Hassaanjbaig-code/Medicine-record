class AppointmentRegister < ApplicationRecord
  belongs_to :user
  belongs_to :doctor_register
end
