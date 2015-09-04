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

  it "should save with valid json" do
    assessment = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"2\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
    date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
    expect {
      create(:developer)
      cohort = create(:cohort)
      unit = create(:unit, start_at: date.yesterday, end_at: date.tomorrow)
      cohort.units << unit
      Assessment.create_from_google_form(assessment)
    }.to change(Assessment, :count).by(1)
  end

  it "should update an existing record if the developer and the due date are the same" do
    first_assessment_result = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"2\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
    second_assessment_result = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
    date = Date.parse(JSON.parse(first_assessment_result["assessment"])["due_at"])
    create(:developer)
    cohort = create(:cohort)
    unit = create(:unit, start_at: date.yesterday, end_at: date.tomorrow)
    cohort.units << unit
    Assessment.create_from_google_form(first_assessment_result)
    Assessment.create_from_google_form(second_assessment_result)
    expect(Assessment.last.score == 1).to be_truthy
  end

  it "should not create duplicate records for the same assessment" do
    first_assessment_result = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"2\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
    second_assessment_result = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
    date = Date.parse(JSON.parse(first_assessment_result["assessment"])["due_at"])
    create(:developer)
    cohort = create(:cohort)
    unit = create(:unit, start_at: date.yesterday, end_at: date.tomorrow)
    cohort.units << unit
    Assessment.create_from_google_form(first_assessment_result)
    expect {
      Assessment.create_from_google_form(second_assessment_result)
    }.to change(Assessment, :count).by(0)
  end

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
#  comments     :text
#
