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

require 'rails_helper'

RSpec.describe ClickerQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
