# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

u1 = User.create!(email: "a@a.com", password: "password")
u2 = User.create!(email: "b@b.com", password: "password")
u3 = User.create!(email: "c@c.com", password: "password")

2.times do |i|
  u1.hosted_events.create(
    name: "#{u1.email}'s Event #{i + 1}",
    description: "Event #{i + 1} description",
    location: "#{u1.email}'s place",
    datetime: Time.now + i.hours
  )
end

2.times do |i|
  u2.hosted_events.create(
    name: "#{u2.email}'s Event #{i + 1}",
    description: "Event #{i + 1} description",
    location: "#{u2.email}'s place",
    datetime: Time.now + i.hours
  )
end

u1.sign_ups.create(event: u2.hosted_events.first)
u2.sign_ups.create(event: u1.hosted_events.first)
u3.sign_ups.create(event: u1.hosted_events.first)
u3.sign_ups.create(event: u1.hosted_events.last)
u3.sign_ups.create(event: u2.hosted_events.first)
u3.sign_ups.create(event: u2.hosted_events.last)
