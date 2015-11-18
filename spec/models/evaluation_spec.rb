require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
