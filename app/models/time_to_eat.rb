class TimeToEat < ApplicationRecord
  belongs_to :medicine
  validates :time_to_eat , presence: true
end
