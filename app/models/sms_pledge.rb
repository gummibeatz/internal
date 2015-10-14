class SmsPledge < ActiveRecord::Base
  belongs_to :donor
end

# == Schema Information
#
# Table name: bash_pledges
#
#  id         :integer          not null, primary key
#  amount     :integer
#  donor_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
