class TimeToEat < ApplicationRecord
  belongs_to :medicine
  validates :time_to_eat , presence: true

  # accepts_nested_attributes_for :time_to_eat, allow_destroy: true
end
