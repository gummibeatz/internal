class Equipment < ActiveRecord::Base
end

# == Schema Information
#
# Table name: equipment
#
#  id           :integer          not null, primary key
#  type         :integer
#  description  :string
#  reference_id :string           default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
