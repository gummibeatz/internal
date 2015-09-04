require 'rails_helper'

RSpec.describe Assessment, type: :model do

  # associations
  it { should belong_to(:developer) }
  it { should belong_to(:unit) }

  # validations
  it { should validate_presence_of(:developer_id) }
  it { should validate_presence_of(:unit_id) }
  it { should validate_presence_of(:due_at) }
  it { should validate_presence_of(:max_score) }
  it { should validate_presence_of(:score) }

  # enum scopes
  it { should define_enum_for(:type) }

end

# == Schema Information
#
# Table name: assessments
#
#  id           :integer          not null, primary key
#  max_score    :float
#  score        :float
#  developer_id :integer
#  github_url   :string
#  due_at       :datetime
#  unit_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  type         :integer
#
