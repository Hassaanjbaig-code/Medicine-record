require "sidekiq-scheduler"


class DoctorSchedular
  include Sidekiq::Worker

  def perform
    # Do something
    @doctor_appointment = Appointment.where('appointment < ?', Time.now)
    p @doctor_appointment
    if @doctor_appointment.empty?
      return "Nothing to update"
    else
      @doctor_appointment.each do |appointment|
        appointment.update(status: true)
      end
    end
  end
end
