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
StartEndMedicine.delete_all
TimeToEat.delete_all
Medicine.delete_all

# Create sample Medicines
10.times do
  Medicine.create!(
    medicine_name: Faker::Name.name,
    use_for: Faker::Lorem.sentence(word_count: 15),
    medicine_mg: Faker::Number.between(from: 50, to: 500)
  )
end

# Create sample StartEndMedicines
20.times do
  StartEndMedicine.create!(
    start_date: Faker::Date.backward(days: 30),
    end_date: Faker::Date.forward(days: 30),
    everyday: Faker::Boolean.boolean,
    medicine_id: Medicine.pluck(:id).sample
  )
end

# Create sample TimeToEats
30.times do
  TimeToEat.create!(
    time_to_eat: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    medicine_id: Medicine.pluck(:id).sample
  )
end

puts "Seeding completed!"
