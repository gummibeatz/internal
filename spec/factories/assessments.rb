FactoryGirl.define do
  factory :assessment do
    max_score 3
    score 2
    developer_id 1
    github_url "http://github.com"
    due_at Date.today
    unit_id 1

  end
end

# == Schema Information
#
# Table name: assessments
#
#  id           :integer          not null, primary key
#  max_score    :float
#  score        :float
#  developer_id :integer
#  github_url   :string
#  due_at       :datetime
#  unit_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  type         :integer
#  comments     :text
#

