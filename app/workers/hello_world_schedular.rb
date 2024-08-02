require 'sidekiq-scheduler'



# class HelloWorldSchedular



#   def perform
#     @find_date = StartEndMedicine.where.not(end_date: Date.today)

#     @find_date.each do |record|
#       @medicine = Medicine.find_by(id: record.medicine_id)
#       next unless @medicine

#       @medicine.user.each do |user|
#         user.time_to_eats.each do |time_to_eat_medicine|
#           Time.use_zone(user.time_zone) do
#             medicine_time = time_to_eat_medicine.time_to_eat.in_time_zone.strftime("%H:%M")
#             current_time = Time.now.in_time_zone.strftime("%H:%M")

#             # Printing the times for debugging
#             p "This is the medicine time", medicine_time
#             p "This is the current time", current_time

#             # Comparing the times
#             p medicine_time == current_time
#           end
#         end
#       end
#     end
#   end

#     # user = User.find(id: user_id)



#     # if user&.logged_in



#     #   PushSubscribe.send_push_notification(user)



#     # else



#     #   Rails.logger.info 'User is not log In'



#     # end


# end


class HelloWorldSchedular
  include Sidekiq::Worker
  def perform
    @find_date = StartEndMedicine.where("end_date >= ?", Date.today)

    @find_date.each do |record|
      @medicine = Medicine.find_by(id: record.medicine_id)
      next unless @medicine

      notification = false

      user = @medicine.user # Assuming a Medicine belongs to a User

      user.time_to_eats.each do |time_to_eat_medicine|
        break if notification
        Time.use_zone(user.time_zone) do
          medicine_time = time_to_eat_medicine.time_to_eat.in_time_zone(user.time_zone).strftime("%H:%M:%P")
          current_time = Time.current.in_time_zone(user.time_zone).strftime("%H:%M:%P")

          # # Printing the times for debugging
          # p "This is the medicine time", medicine_time
          # p "This is the current time", current_time

          # # Comparing the times
          # p medicine_time == current_time
          if medicine_time == current_time
            PushSubscribe.send_push_notification(user.id , @medicine.medicine_name)
            notification = true
          end
        end
      end
    end
  end
end
