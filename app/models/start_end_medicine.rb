class StartEndMedicine < ApplicationRecord
  belongs_to :medicine
  validates :start_date, presence: true
end
