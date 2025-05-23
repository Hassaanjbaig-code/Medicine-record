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
  has_many :appointment_registers, dependent: :destroy
  has_one :patient, dependent: :destroy

  # def after_sign_up_path_for
  #   if self.doctor
  #     # redirect_to new_doctor_register_path
  #     redirect_to "/doctor_registers/new"
  #   else
  #     # redirect_to new_patient_path
  #     redirect_to "/patients/new"
  #   end
  # end

  def logged_in?
    !!self.session_token
  end
end
