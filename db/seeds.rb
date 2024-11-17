# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding Database with Users, Events, and Sign Ups"

u1 = User.create!(email: "a@a.com", password: "password")
u2 = User.create!(email: "b@b.com", password: "password")
u3 = User.create!(email: "c@c.com", password: "password")
u4 = User.create!(email: "d@d.com", password: "password")

# upcoming events
n = 3
n.times do |i|
  u1.hosted_events.create(
    name: "#{u1.email}'s Upcoming Event #{i + 1}",
    description: "Event #{i + 1} description",
    location: "#{u1.email}'s place",
    datetime: (i + 1).days.from_now
  )

  u2.hosted_events.create(
    name: "#{u2.email}'s Upcoming Event #{i + 1}",
    description: "Event #{i + 1} description",
    location: "#{u2.email}'s place",
    datetime: (i + 1).days.from_now
  )
end

# past events

n.times do |i|
  u1.hosted_events.create(
    name: "#{u1.email}'s Historic Event #{n - i}",
    description: "Event #{n - i} description",
    location: "#{u1.email}'s place",
    datetime: (i + 1).days.ago
  )

  u2.hosted_events.create(
    name: "#{u2.email}'s Historic Event #{n - i}",
    description: "Event #{n - i} description",
    location: "#{u2.email}'s place",
    datetime: (i + 1).days.ago
  )
end

u1.attended_events << u2.hosted_events
u2.attended_events << u1.hosted_events
u3.attended_events << u1.hosted_events
u3.attended_events << u2.hosted_events
