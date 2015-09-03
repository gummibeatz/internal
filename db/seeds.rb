# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# admin
#

3.times do |idx|
  admin = User.create(
    email: "admin#{idx}@c4q.nyc",
    name: "Admin#{idx}",
    image: "http://suzannestutzman.com/wordpress1/wp-content/uploads/2015/01/R-bike-iguana1.jpg",
    password: Devise.friendly_token[0,20]
  )
end

cohort = Cohort.create!(
  name: "access code",
  version: "1.0"
)

unit = cohort.units.create!(
  start_at: 1.day.ago,
  end_at: 20.days.from_now
)

developer = cohort.developers.new(
  email: "c4qdeveloper@example.com",
  github_username: "c4qdeveloper",
  first_name: "c4q",
  last_name: "developer",
  full_name: "c4qdeveloper"
)
developer.save

10.times do |idx|
  developer = cohort.developers.new(
    email: "developer#{idx}@example.com",
    github_username: "developer#{idx}",
    first_name: "developer#{idx}",
    last_name: "example",
    full_name: "developer#{idx}example"
  )

  # developer user
  developer_user = developer.create_user(
    email: developer.email,
    name: developer.full_name,
    image: "http://suzannestutzman.com/wordpress1/wp-content/uploads/2015/01/R-bike-iguana1.jpg",
    password: Devise.friendly_token[0,20]
  )
end
