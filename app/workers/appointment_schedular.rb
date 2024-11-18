require 'sidekiq-scheduler'

class AppointmentSchedular
  include Sidekiq::Worker

  def perform
    @find_appointment = Appointment.where("appointment <= ?", Time.now)

    @find_appointment.each do |appointment|
      @doctor = Doctor.find_by(id: appointment.doctor_id)
      next unless @doctor
      break if appointment.status == true

      @time_zone = User.find_by_id(@doctor.user_id)
      Time.use_zone(@time_zone.time_zone) do
        doctor_time = appointment.appointment.in_time_zone(@time_zone.time_zone).strftime("%H:%M:%P")
        current_time = Time.current.in_time_zone(@time_zone.time_zone).strftime("%H:%M:%P")

        if doctor_time == current_time
          PushSubscribe.send_push_notification(@time_zone.id, @doctor.Fullname)
          appointment.status = false
        end
      end
    end
  end
end
