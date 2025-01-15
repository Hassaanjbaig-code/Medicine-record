module DoctorRegistersHelper
  def check_availabilities doctor, time
    working_Day = doctor.availabilities.last.day_of_week.to_s.chars
    days = working_Day.map do |number|
      Availability.day_of_weeks.key(number.to_i)
    end

    today_included = days.include?(time.strftime("%A").downcase)

    return today_included
  end
end
