class Medicine < ApplicationRecord
  has_many :start_end_medicines , dependent: :destroy
  has_many :time_to_eat , dependent: :destroy

  accepts_nested_attributes_for :start_end_medicine , :time_to_eat, allow_destroy: true
end
