# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

# # db/seeds.rb

# require 'faker'

# # Clear existing data
# # StartEndMedicine.delete_all
# # TimeToEat.delete_all
# # Medicine.delete_all

# # # Create sample Medicines
# # 10.times do
# #   Medicine.create!(
# #     medicine_name: Faker::Name.name,
# #     use_for: Faker::Lorem.sentence(word_count: 15),
# #     medicine_mg: Faker::Number.between(from: 50, to: 500),
# #     image: Faker::LoremFlickr.image
# #   )
# # end

# # # Create sample StartEndMedicines
# # 20.times do
# #   StartEndMedicine.create!(
# #     start_date: Faker::Date.backward(days: 30),
# #     end_date: Faker::Date.forward(days: 30),
# #     everyday: Faker::Boolean.boolean,
# #     medicine_id: Medicine.pluck(:id).sample
# #   )
# # end

# # # Create sample TimeToEats
# # 30.times do
# #   TimeToEat.create!(
# #     time_to_eat: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
# #     medicine_id: Medicine.pluck(:id).sample
# #   )
# # end

# # puts "Seeding completed!"


# # Temporarily disable Elasticsearch callbacks
# # DoctorRegister.__elasticsearch__.disable_callbacks

# # Your seed logic here

# # Re-enable Elasticsearch callbacks after seeding
# # DoctorRegister.__elasticsearch__.enable_callbacks

# # Create users
# # Create users
# 5.times do |i|
#   user = User.create!(
#     email: "doctor#{i + 1}@example.com",
#     password: "password123",
#     password_confirmation: "password123",
#     time_zone: "Asia/Karachi", # Updated time_zone to "Asia/Karachi"
#     name: "Doctor #{i + 1}",
#     doctor: true # Ensures this user is a doctor
#   )

#   # Create associated doctor_register
#   doctor_register = DoctorRegister.create!(
#     First_name: "DoctorFirstName#{i + 1}",
#     Last_name: "DoctorLastName#{i + 1}",
#     date_of_birth: Date.new(1980, 1, 1) + i.years,
#     gender: i.even? ? "Male" : "Female",
#     email: user.email,
#     practicing_from: Date.new(2005, 1, 1) + i.years,
#     user_id: user.id
#   )

#   # Create qualifications for each doctor
#   2.times do |j|
#     Qualification.create!(
#       qualification_name: "Qualification#{j + 1}",
#       institute_name: "Institute#{j + 1}",
#       procurement_year: 2000 + j + i,
#       doctor_register_id: doctor_register.id
#     )
#   end

#   # Create specializations for each doctor
#   Specialization.create!(
#     name: "Specialization#{i + 1}",
#     license: "License#{i + 1}",
#     issuing_authority: "Authority#{i + 1}",
#     issue_date: Date.new(2010, 1, 1),
#     expire_date: Date.new(2030, 1, 1),
#     doctor_register_id: doctor_register.id
#   )

#   # Create clinic for each doctor
#   Clinic.create!(
#     clinic_name: "Clinic#{i + 1}",
#     address: "123 Street #{i + 1}, City",
#     contact_number: "123456789#{i + 1}",
#     latitude: 25.0 + i,
#     logitude: 55.0 + i,
#     doctor_register_id: doctor_register.id
#   )

#   # Create availability for each doctor
#   Availability.create!(
#     day_of_week: i + 1,
#     available_from: "09:00:00",
#     available_to: "17:00:00",
#     doctor_register_id: doctor_register.id,
#     user_id: user.id
#   )
# end

# # puts "Seed data successfully created with Asia/Karachi time zone!"

# puts "Seed data successfully created!"


require 'faker'

13.times do
  # Create a doctor user with doctor flag set to true
  #
  time_zone_set = ActiveSupport::TimeZone.all.sample.tzinfo.identifier
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: "password",       # Set a default password for testing
    time_zone: time_zone_set,
    name: Faker::Name.name,
    doctor: true
  )

  # Create the doctor's registration record
  doctor = DoctorRegister.create!(
    First_name: Faker::Name.first_name,
    Last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday(min_age: 30, max_age: 65),
    gender: ["Male", "Female"].sample,
    email: user.email,           # Using the same email as the User
    practicing_from: Faker::Date.backward(days: 365 * 10),
    user_id: user.id
  )

  # Create an associated specialization record
  Specialization.create!(
    name: Faker::Job.field,
    license: Faker::Alphanumeric.alpha(number: 10).upcase,
    issuing_authority: Faker::Company.name,
    issue_date: Faker::Date.backward(days: 365 * 5),
    expire_date: Faker::Date.forward(days: 365 * 2),
    doctor_register_id: doctor.id
  )

  # Create an associated qualification record
  Qualification.create!(
    qualification_name: Faker::Educator.course_name,
    institute_name: Faker::University.name,
    procurement_year: Faker::Number.between(from: 1990, to: 2020),
    doctor_register_id: doctor.id
  )

  # Create an associated availability record
  Availability.create!(
    day_of_week: Faker::Number.between(from: 0, to: 6),  # Assuming 0=Sunday, 6=Saturday
    available_from: "09:00",   # Example fixed time, adjust as needed
    available_to: "17:00",     # Example fixed time, adjust as needed
    doctor_register_id: doctor.id,
    user_id: user.id
  )

  # Create an associated clinic record
  Clinic.create!(
    clinic_name: "#{Faker::Company.name} Clinic",
    address: Faker::Address.full_address,
    contact_number: Faker::PhoneNumber.phone_number,
    doctor_register_id: doctor.id,
    latitude: Faker::Address.latitude,
    logitude: Faker::Address.longitude   # Using the column name as provided in your schema
  )

  puts "Created Doctor #{doctor.First_name} #{doctor.Last_name} with email #{user.email}"
end
