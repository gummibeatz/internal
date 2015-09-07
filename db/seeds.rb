user = User.create(
  email: "admin@c4q.nyc",
  name: "Admin Professional",
  image: "http://suzannestutzman.com/wordpress1/wp-content/uploads/2015/01/R-bike-iguana1.jpg",
  password: Devise.friendly_token[0,20]
)

cohort = Cohort.create!( name: "access code", version: "1.0")
unit = cohort.units.create!( start_at: 30.days.ago, end_at: 20.days.ago)
unit_2 = cohort.units.create!( start_at: 19.days.ago, end_at: 10.days.ago)
unit_3 = cohort.units.create!( start_at: 9.days.ago, end_at: 10.days.from_now)

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
  image: "https://avatars3.githubusercontent.com/u/8087061?v=3&s=96",
  password: Devise.friendly_token[0,20]
)

attendance = developer.attendances.create!([
  {status: "on_time", timestamp: Date.today},
  {status: "late_excused", timestamp: 2.days.ago},
  {status: "on_time", timestamp: 4.days.ago},
  {status: "on_time", timestamp: 5.days.ago},
  {status: "late_unexcused_5_minutes", timestamp: 1.week.ago},
  {status: "on_time", timestamp: 9.days.ago},
  {status: "late_unexcused_10_minutes", timestamp: 11.days.ago},
  {status: "on_time", timestamp: 12.days.ago},
  {status: "on_time", timestamp: 14.days.ago},
  {status: "on_time", timestamp: 16.days.ago},
  {status: "absent_unexcused", timestamp: 18.days.ago},
  {status: "absent_unexcused", timestamp: 19.days.ago},
  {status: "on_time", timestamp: 21.days.ago},
  {status: "on_time", timestamp: 23.days.ago},
  {status: "on_time", timestamp: 25.days.ago},
  {status: "on_time", timestamp: 26.days.ago},
  {status: "on_time", timestamp: 28.days.ago},
  {status: "on_time", timestamp: 30.days.ago},
])

assessment = developer.assessments.create!([
  {unit_id: unit.id,
  github_url: "http://github.com",
  max_score: 3,
  score: 2,
  type: "homework",
  due_at: 24.days.ago.to_datetime},

  {unit_id: unit.id,
  github_url: "http://github.com",
  max_score: 10,
  score: 7,
  type: "exam",
  due_at: 18.days.ago},

  {unit_id: unit_2.id,
  github_url: "http://github.com",
  max_score: 4,
  score: 4,
  type: "homework",
  due_at: 10.days.ago},

  {unit_id: unit_2.id,
  github_url: "http://github.com",
  max_score: 5,
  score: 4,
  type: "homework",
  due_at: 3.days.from_now},

])
