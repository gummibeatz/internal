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

require 'rails_helper'

RSpec.describe ClickerAnswer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
