FactoryGirl.define do

  factory :user do
    email User.admin_whitelist.first
    password "queensc4q"
  end

end
