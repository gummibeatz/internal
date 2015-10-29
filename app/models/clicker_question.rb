class ClickerQuestion < ActiveRecord::Base
  has_many :clicker_answers, dependent: :destroy
  accepts_nested_attributes_for :clicker_answers, :reject_if => :all_blank, :allow_destroy => true
  validates :question, presence: true

  def normalized_votes_for(answer)
    votes_summary == 0 ? 0 : (answer.votes.count.to_f / votes_summary)
  end

  def votes_summary
    clicker_answers.inject(0) { |summary, answer| summary + answer.votes.count}
  end

end

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

