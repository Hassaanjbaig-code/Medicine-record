class Medicine < ApplicationRecord
  has_many :start_end_medicines , dependent: :destroy
  has_many :time_to_eat , dependent: :destroy
end
