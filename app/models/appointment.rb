class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :doctor
  

  validates :appointment, presence: true
  validates :status, inclusion: { in: [true, false] }

end
