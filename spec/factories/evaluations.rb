FactoryGirl.define do
  factory :evaluation do
    
  end

end

# == Schema Information
#
# Table name: evaluations
#
#  id             :integer          not null, primary key
#  developer_id   :integer
#  json_scores    :text
#  json_responses :text
#  type           :integer
#  unit           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
