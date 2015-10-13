require 'rails_helper'

RSpec.describe BashDonor, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
