require 'rails_helper'

RSpec.describe Assignment, type: :model do

  describe "associations" do
    it { should have_many(:assessments) }
  end

  describe "validations" do
    it { should validate_presence_of(:unit_id) }
    it { should validate_presence_of(:due_at) }
    it { should validate_presence_of(:max_score) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:github_url) }
  end

  describe "creates an assignment" do
    expect {
      
    }
  end

end
