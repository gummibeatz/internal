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
        "Thank you for your pledge of $%s to C4Q. Your contribution will go towards expanding opportunity in tech. Please tell us your name so we can follow up.",
        "Thanks, %s. In 140 characters, please tell us why you choose to support C4Q (this message will be displayed on our public pledge board)",
        "Thank you so much. We'll be in touch soon.",
        "Hey, %s! Have you tried the mochi ice cream? If you'd like to make another pledge just enter the amount.",
        "Thanks, %s, for your for pledge of $%s. If you'd like to make another pledge just enter the amount."
      ][idx] % strings
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