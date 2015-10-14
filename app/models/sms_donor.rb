class SmsDonor < ActiveRecord::Base

  has_many :messages, foreign_key: "sms_donor_id", class_name: "SmsDonorMessage", dependent: :destroy
  has_many :pledges, foreign_key: "sms_donor_id", class_name: "SmsPledge", dependent: :destroy

  def self.create_from_twilio_response(params)
    donor = SmsDonor.create(
      phone_number: params[:From],
      state: params[:FromState],
      city: params[:FromCity],
      zip: params[:FromZip],
      country: params[:FromCountry]
    )
    donor
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
