FactoryGirl.define do
  factory :bash_donor do
    phone_number "MyString"
name "MyString"
state "MyString"
zip "MyString"
country "MyString"
  end

end

# == Schema Information
#
# Table name: bash_donors
#
#  id           :integer          not null, primary key
#  phone_number :string
#  name         :string
#  state        :string
#  city         :string
#  zip          :string
#  country      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
