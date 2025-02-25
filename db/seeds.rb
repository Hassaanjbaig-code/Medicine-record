# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

require 'faker'

# Clear existing data
# StartEndMedicine.delete_all
# TimeToEat.delete_all
# Medicine.delete_all

# # Create sample Medicines
# 10.times do
#   Medicine.create!(
#     medicine_name: Faker::Name.name,
#     use_for: Faker::Lorem.sentence(word_count: 15),
#     medicine_mg: Faker::Number.between(from: 50, to: 500),
#     image: Faker::LoremFlickr.image
#   )
# end

# # Create sample StartEndMedicines
# 20.times do
#   StartEndMedicine.create!(
#     start_date: Faker::Date.backward(days: 30),
#     end_date: Faker::Date.forward(days: 30),
#     everyday: Faker::Boolean.boolean,
#     medicine_id: Medicine.pluck(:id).sample
#   )
# end

# # Create sample TimeToEats
# 30.times do
#   TimeToEat.create!(
#     time_to_eat: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
#     medicine_id: Medicine.pluck(:id).sample
#   )
# end

# puts "Seeding completed!"


# Temporarily disable Elasticsearch callbacks
# DoctorRegister.__elasticsearch__.disable_callbacks

# Your seed logic here

# Re-enable Elasticsearch callbacks after seeding
# DoctorRegister.__elasticsearch__.enable_callbacks

# Create users
# Create users
5.times do |i|
  user = User.create!(
    email: "doctor#{i + 1}@example.com",
    password: "password123",
    password_confirmation: "password123",
    time_zone: "Asia/Karachi", # Updated time_zone to "Asia/Karachi"
    name: "Doctor #{i + 1}",
    doctor: true # Ensures this user is a doctor
  )

  # Create associated doctor_register
  doctor_register = DoctorRegister.create!(
    First_name: "DoctorFirstName#{i + 1}",
    Last_name: "DoctorLastName#{i + 1}",
    date_of_birth: Date.new(1980, 1, 1) + i.years,
    gender: i.even? ? "Male" : "Female",
    email: user.email,
    practicing_from: Date.new(2005, 1, 1) + i.years,
    user_id: user.id
  )

  # Create qualifications for each doctor
  2.times do |j|
    Qualification.create!(
      qualification_name: "Qualification#{j + 1}",
      institute_name: "Institute#{j + 1}",
      procurement_year: 2000 + j + i,
      doctor_register_id: doctor_register.id
    )
  end

  # Create specializations for each doctor
  Specialization.create!(
    name: "Specialization#{i + 1}",
    license: "License#{i + 1}",
    issuing_authority: "Authority#{i + 1}",
    issue_date: Date.new(2010, 1, 1),
    expire_date: Date.new(2030, 1, 1),
    doctor_register_id: doctor_register.id
  )

  # Create clinic for each doctor
  Clinic.create!(
    clinic_name: "Clinic#{i + 1}",
    address: "123 Street #{i + 1}, City",
    contact_number: "123456789#{i + 1}",
    latitude: 25.0 + i,
    logitude: 55.0 + i,
    doctor_register_id: doctor_register.id
  )

  # Create availability for each doctor
  Availability.create!(
    day_of_week: i + 1,
    available_from: "09:00:00",
    available_to: "17:00:00",
    doctor_register_id: doctor_register.id,
    user_id: user.id
  )
end

# puts "Seed data successfully created with Asia/Karachi time zone!"

puts "Seed data successfully created!"
