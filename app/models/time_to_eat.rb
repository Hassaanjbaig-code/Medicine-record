class TimeToEat < ApplicationRecord
  belongs_to :medicine
  validates :time_to_eat , presence: true
  belongs_to :user

  # accepts_nested_attributes_for :time_to_eat, allow_destroy: true

  def self.extract_time(datetime)
    datetime.strftime("%H:%M:%S")
  end
end
