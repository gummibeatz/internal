FactoryGirl.define do
  factory :unit do
    start_at 10.days.ago
    end_at 10.days.from_now
  end
end
