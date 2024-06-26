class Medicine < ApplicationRecord
  has_many :start_end_medicines , dependent: :destroy
  has_many :time_to_eats , dependent: :destroy
  belongs_to :user

  # accepts_nested_attributes_for :start_end_medicines, reject_if: :all_black , allow_destroy: true
  accepts_nested_attributes_for :time_to_eats, allow_destroy: true
end
