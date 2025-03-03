module DoctorRegistersHelper
  def check_availabilities doctor, time
    working_Day = doctor.availabilities.last.day_of_week.to_s.chars
    days = working_Day.each do |number|
      Availability.day_of_weeks.key(number.to_i)
    end

    p "This is the days that patient book", days
    today_included = days.include?(time.strftime("%A").downcase)

    return today_included
  end

  def check_doctor_complete(user)
    incomplete = false
    incomplete ||= user.doctor_register.nil?
    incomplete ||= user.doctor_register&.qualifications.nil?
    incomplete ||= user.doctor_register&.clinics.nil?
    incomplete ||= user.doctor_register&.availabilities.nil?
    incomplete ||= user.doctor_register&.specializations.nil?
    return incomplete
    # unless incomplete
    #   # Code to hide the doctor_register from the index page
    #   # This will depend on how you are displaying the doctor_registers in the index page
    #   # For example, if you are using an instance variable @doctor_registers, you can filter it
    #   @doctor_registers = @doctor_registers.reject { |dr| dr == user.doctor_register } if defined?(@doctor_registers)
    # end
  end
end
