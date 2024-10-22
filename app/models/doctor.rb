class Doctor < ApplicationRecord
  has_many :appointments, dependent: :destroy
  belongs_to :user

  validates :Fullname, :Specialty, :Email, presence: true
end
