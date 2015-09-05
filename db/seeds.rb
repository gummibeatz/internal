# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# admin

user = User.create(
  email: "admin@c4q.nyc",
  name: "Admin Professional",
  image: "http://suzannestutzman.com/wordpress1/wp-content/uploads/2015/01/R-bike-iguana1.jpg",
  password: Devise.friendly_token[0,20]
)

cohort = Cohort.create!( name: "access code", version: "1.0")
unit = cohort.units.create!( start_at: 1.day.ago, end_at: 20.days.from_now)

developer = cohort.developers.create!(
  email: "c4qdeveloper@example.com",
  github_username: "c4qdeveloper",
  first_name: "c4q",
  last_name: "developer",
  full_name: "c4qdeveloper"
)

developer_user = developer.create_user(
  email: developer.email,
  name: developer.full_name,
  image: "http://suzannestutzman.com/wordpress1/wp-content/uploads/2015/01/R-bike-iguana1.jpg",
  password: Devise.friendly_token[0,20]
)

attendance = developer.attendances.create!([
  {status: "on_time", timestamp: Time.now},
  {status: "late_excused", timestamp: Time.now-1}
])

assessment = developer.assessments.create!([
  {unit_id: unit.id,
  github_url: "http://github.com/accesscode-2-2/unit-1-assessment",
  max_score: 3,
  score: 2,
  type: "homework",
  due_at: Date.parse("20150901").to_datetime},
  
  {unit_id: unit.id,
  github_url: "http://github.com/accesscode-2-2/unit-1-assessment",
  max_score: 10,
  score: 7,
  type: "exam",
  due_at: Date.parse("20150901").to_datetime},
  
  {unit_id: unit.id,
  github_url: "http://github.com/accesscode-2-2/unit-1-assessment",
  max_score: 4,
  score: 4,
  type: "homework",
  due_at: Date.parse("20150901").to_datetime},
  
  {unit_id: unit.id,
  github_url: "http://github.com/accesscode-2-2/unit-1-assessment",
  max_score: 5,
  score: 4,
  type: "project",
  due_at: Date.parse("20150901").to_datetime},

])
