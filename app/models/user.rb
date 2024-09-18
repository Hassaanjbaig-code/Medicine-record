class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable, :confirmable,  and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  validates :time_zone, presence: true, inclusion: {
    in: ActiveSupport::TimeZone.all.map(&:tzinfo).map(&:identifier)
  }

  has_many :medicines, dependent: :destroy
  has_many :push_subscribe, dependent: :destroy
  has_many :time_to_eats, dependent: :destroy

  def logged_in?
    !!self.session_token
  end
end
