FactoryGirl.define do
  factory :bash_donor_message do
    message "MyText"
sid "MyString"
account_sid "MyString"
  end

end

# == Schema Information
#
# Table name: bash_donor_messages
#
#  id              :integer          not null, primary key
#  message         :text
#  message_sid     :string
#  account_sid     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  donor_id        :integer
#  sms_message_sid :string
#  sms_sid         :string
#
