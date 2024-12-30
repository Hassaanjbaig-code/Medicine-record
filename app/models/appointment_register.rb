class AppointmentRegister < ApplicationRecord
  belongs_to :user
  belongs_to :doctorRegister
end
