class User < ApplicationRecord
  # after_commit :after_sign_up_path_for
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
  has_many :doctors, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_one :doctor_register, dependent: :destroy
  has_many :appointments_registers, dependent: :destroy

  # def after_sign_up_path_for
  #   if self.doctor
  #     doctor_registers_path
  #   else
  #     root_path
  #   end
  # end

  def logged_in?
    !!self.session_token
  end
end
