class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  validates :time_zone, presence: true, inclusion: {
    in: ActiveSupport::TimeZone.all.map(&:tzinfo).map(&:identifier)
  }

  has_many :medicines , dependent: :destroy
end
