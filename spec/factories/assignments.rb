FactoryGirl.define do
  factory :assignment do
    due_at 10.days.from_now
    max_score 2
    type 0
    active true
    github_url "github.com"
  end

end

# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  max_score  :integer
#  type       :integer
#  github_url :string
#  due_at     :datetime
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cohort_id  :integer
#
