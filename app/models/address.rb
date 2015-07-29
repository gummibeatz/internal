class Address < ActiveRecord::Base
end

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  address_1  :string
#  address_2  :string
#  city       :string
#  state      :string
#  zip        :string
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
