FactoryGirl.define do
  factory :attendance do
    status  "on_time"
    timestamp { Date.today.to_datetime }
  end
end
