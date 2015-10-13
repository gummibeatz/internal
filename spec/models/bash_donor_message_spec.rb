require 'rails_helper'

RSpec.describe BashDonorMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
