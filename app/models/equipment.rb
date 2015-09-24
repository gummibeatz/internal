class Equipment < ActiveRecord::Base
  
  scope :items_checked_out, ->{ where.not(:date_assigned => nil).where(:date_returned => nil) }

  enum model: [:moto_g] 
  enum return_condition: [:like_new]
  
  belongs_to :developer
  

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
