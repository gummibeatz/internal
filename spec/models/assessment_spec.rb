require 'rails_helper'

RSpec.describe Assessment, type: :model do

  describe "associations" do
    it { should belong_to(:developer) }
    it { should belong_to(:assignment) }
  end

  describe "validations" do
    it { should validate_presence_of(:developer_id) }
    it { should validate_presence_of(:assignment_id) }
    it { should validate_presence_of(:due_at) }
    it { should validate_presence_of(:max_score) }
    it { should validate_presence_of(:score) }
  end

  describe "enum scope" do
    it { should define_enum_for(:type) }
  end

  describe "methods" do
    let(:assessment) { {"assessment"=>"{\"type\":\"0\",\"github_url\":\"github.com\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"2\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"} }

    it "should save with valid json" do
      date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
      expect {
        developer = create(:developer)
        cohort = create(:cohort)
        assignment = create(:assignment, github_url: "github.com")
        cohort.assignments << assignment
        Assessment.create_from_google_form(assessment)
      }.to change(Assessment, :count).by(1)
    end

    it "should update an existing record if the developer and the due date are the same" do
      updated_assessment = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"github.com\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
      date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
      developer = create(:developer)
      cohort = create(:cohort)
      assignment = create(:assignment, github_url: "github.com")
      cohort.assignments << assignment
      Assessment.create_from_google_form(assessment)
      Assessment.create_from_google_form(updated_assessment)
      expect(Assessment.last.score == 1).to be_truthy
    end

    it "should save assessments from different assignments as different records" do
      new_assessment = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"http://github.com\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 16 Aug 2015 04:00:00 GMT\"}"}
      date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
      developer = create(:developer)
      cohort = create(:cohort)
      assignment = create(:assignment, github_url: "github.com")
      assignment2 = create(:assignment, github_url: "http://github.com")
      cohort.assignments << assignment
      cohort.assignments << assignment2
      expect {
        Assessment.create_from_google_form(assessment)
        Assessment.create_from_google_form(new_assessment)
      }.to change(Assessment, :count).by(2)
    end

    it "should not create duplicate records for the same assessment" do
      updated_assessment = {"assessment"=>"{\"type\":\"0\",\"http://github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
      date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
      create(:developer)
      cohort = create(:cohort)
      unit = create(:unit, start_at: date.yesterday, end_at: date.tomorrow)
      cohort.units << unit
      Assessment.create_from_google_form(assessment)
      expect {
        Assessment.create_from_google_form(updated_assessment)
      }.to change(Assessment, :count).by(0)
    end
  
    fit "should send_reports after creation" do
      expect {
        developer = create(:developer)
        developer.create_user!(
          email: developer.email,
          password: Devise.friendly_token
        )
        cohort = create(:cohort)
        assignment = create(:assignment, github_url: "github.com")
        cohort.assignments << assignment
        developer.assessments.create!(
          assignment_id: assignment.id,
          due_at: assignment.due_at,
          max_score: assignment.max_score,
          score: 2,
          type: assignment.type
        )
      }.to change(Notification, :count).by(1)
    end

    fit "should send_reports after update" do
      developer = create(:developer)
      developer.create_user!(
       email: developer.email,
       password: Devise.friendly_token
      )
      cohort = create(:cohort)
      assignment = create(:assignment, github_url: "github.com")
       cohort.assignments << assignment
       developer.assessments.create!(
       assignment_id: assignment.id,
       due_at: assignment.due_at,
       max_score: assignment.max_score,
       score: 2,
       type: assignment.type
      )
       developer.assessments.create!(
         assignment_id: assignment.id,
         due_at: assignment.due_at,
         max_score: assignment.max_score,
         score:2,
         type: assignment.type
       )
       expect {
        assessment = developer.assessments.most_recent
        assessment.score = 3
        assessment.save!
       }.to change(Notification, :count).by(1)
    end
    
  end

end

# == Schema Information
#
# Table name: assessments
#
#  id            :integer          not null, primary key
#  max_score     :float
#  score         :float
#  developer_id  :integer
#  github_url    :string
#  due_at        :datetime
#  unit_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type          :integer
#  comments      :text
#  assignment_id :integer
#
