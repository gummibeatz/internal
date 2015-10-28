# == Schema Information
#
# Table name: clicker_answers
#
#  id                  :integer          not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  developer_id        :integer
#  clicker_question_id :integer
#  is_correct          :boolean
#  choice              :integer
#  answer              :text
#

FactoryGirl.define do
  factory :clicker_answer do
    
  end

end
