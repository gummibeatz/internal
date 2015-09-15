require 'rails_helper'

RSpec.describe Assignment, type: :model do

  describe "associations" do
    it { should have_many(:assessments) }
  end

  describe "validations" do
    it { should validate_presence_of(:due_at) }
    it { should validate_presence_of(:max_score) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:github_url) }
  end

  describe "creates an assignment" do
  end

end

# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  max_score  :integer
#  type       :integer
#  unit_id    :integer
#  github_url :string
#  due_at     :datetime
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
