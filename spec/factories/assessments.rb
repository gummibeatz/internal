FactoryGirl.define do
  factory :assessment do
    max_score 1.5
score 1.5
developer_id 1
github_url "MyString"
due_at "2015-09-03 22:38:46"
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
#
