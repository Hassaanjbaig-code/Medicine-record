class Room < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor_register
  has_many :messages, dependent: :destroy
end
