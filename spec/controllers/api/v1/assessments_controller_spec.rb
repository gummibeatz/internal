require 'rails_helper'

RSpec.describe Api::V1::AssessmentsController, type: :controller do

  let(:assessment) { {"assessment"=>"{\"type\":\"0\",\"github_url\":\"github.com\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"2\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"} }

  before(:each) do
    date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
    create(:developer)
    cohort = create(:cohort)
    assignment = create(:assignment, github_url: "github.com")
    cohort.assignments << assignment
  end

  describe "POST create" do
    it "should create a record with valid json" do
      expect {
        post :create, assessment
      }.to change(Assessment, :count).by(1)
    end
  end

end
