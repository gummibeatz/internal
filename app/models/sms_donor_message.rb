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

  def self.bash_messages(idx, strings=[])
      messages = [
        "Thank you for your pledge of $%s to C4Q. Your contribution will go towards expanding opportunity in tech. Please tell us your full name so we can follow up.",
        "Thanks, %s. In 140 characters, please tell us why you choose to support C4Q (this message will be displayed on our public pledge board)",
        "Thank you so much. We'll be in touch soon to complete the contribution.",
        "Hey, %s! Have you tried the mochi ice cream? If you'd like to make another pledge just enter the amount.",
        "Thanks, %s, for your for pledge of $%s. If you'd like to make another pledge just enter the amount.",
        "Thank you so much for your support!"
      ][idx] % strings
  end

end

# == Schema Information
#
# Table name: sms_donor_messages
#
#  id              :integer          not null, primary key
#  message         :text
#  sms_sid         :string
#  account_sid     :string
#  sms_message_sid :string
#  message_sid     :string
#  sms_donor_id    :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
