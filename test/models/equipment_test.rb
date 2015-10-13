require 'test_helper'

class EquipmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: equipment
#
#  id                     :integer          not null, primary key
#  description            :string
#  reference_id           :string           default("0")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  developer_id           :integer
#  model                  :string
#  account_name           :string
#  date_assigned          :datetime
#  signed_off_by          :string
#  policy_signed          :boolean
#  cc_info_on_google_form :boolean
#  date_returned          :datetime
#  return_condition       :integer
#
