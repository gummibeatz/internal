class ClickerAnswer < ActiveRecord::Base
  belongs_to :clicker_question
  
  has_many :votes, dependent: :destroy
  has_many :developers, through: :votes

  validates :answer, presence: true
end

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

