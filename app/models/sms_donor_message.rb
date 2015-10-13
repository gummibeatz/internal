class SmsDonorMessage < ActiveRecord::Base

  def self.create_message_from_twilio(params)
      message = SmsDonorMessage.create(
        message: params[:Body],
        message_sid: params[:MessageSid],
        sms_sid: params[:SmsSid],
        sms_message_sid: params[:SmsMessageSid],
        account_sid: params[:AccountSid]
      )
      message
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
