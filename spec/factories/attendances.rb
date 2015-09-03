FactoryGirl.define do
  factory :attendance do
    status  "on_time"
    timestamp { Date.today.to_datetime }
  end
end

# == Schema Information
#
# Table name: attendances
#
#  id           :integer          not null, primary key
#  status       :integer          default(0)
#  developer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  timestamp    :datetime
#
