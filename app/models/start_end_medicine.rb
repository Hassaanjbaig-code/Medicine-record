class StartEndMedicine < ApplicationRecord
  belongs_to :medicine
  validates :start_time, presence: true
  validates :end_time, presence: true
end
