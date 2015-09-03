FactoryGirl.define do

  factory :user do
    factory :whitelist_user do
      email User.admin_whitelist.first
      password "queensc4q"
    end

    factory :random_user do
      email "test@example.com"
      password "123234"
    end
  end

end
