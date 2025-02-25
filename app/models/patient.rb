class Patient < ApplicationRecord
  has_many :rooms, dependent: :destroy
  belongs_to :user
  validates :phone_number, presence: true, format: { with: /\A[+\d\- ]+\z/, message: "is invalid" }

  # searchkick
end
