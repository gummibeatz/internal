class Evaluation < ActiveRecord::Base
  
  enum type: [:EOU,:interview]
  belongs_to :developer
  
  validates :developer_id, presence: true
  
  def self.create_from_google_form(form_data)
     
  end
  
  def self.inheritance_column
    "inheritance_type"
  end

end

# == Schema Information
#
# Table name: evaluations
#
#  id             :integer          not null, primary key
#  developer_id   :integer
#  json_scores    :text
#  json_responses :text
#  type           :integer
#  unit           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
