# == Schema Information
#
# Table name: clicker_questions
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  question       :text
#  correct_choice :integer
#

FactoryGirl.define do
  factory :clicker_question do
    
  end

end
