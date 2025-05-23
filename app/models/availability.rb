class Availability < ApplicationRecord
  belongs_to :doctor_register


  enum day_of_week: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }, _prefix: true

  attribute :day_of_week, :integer
end
