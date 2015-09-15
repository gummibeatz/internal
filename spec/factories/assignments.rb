FactoryGirl.define do
  factory :assignment do
    
  end

end

# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  max_score  :integer
#  type       :integer
#  unit_id    :integer
#  github_url :string
#  due_at     :datetime
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
