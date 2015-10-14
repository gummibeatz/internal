class SmsPledge < ActiveRecord::Base
  belongs_to :donor, class_name: "SmsDonor", foreign_key: :sms_donor_id

  def as_json(options={})
    serializable_hash( options).merge({donor: donor.as_json})
  end
end

# == Schema Information
#
# Table name: sms_pledges
#
#  id           :integer          not null, primary key
#  sms_donor_id :integer
#  message      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  amount       :float
#
