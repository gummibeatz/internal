require 'rails_helper'

RSpec.describe Assessment, type: :model do
<<<<<<< HEAD

  describe "associations" do
    it { should belong_to(:developer) }
    it { should belong_to(:unit) }
  end

  describe "validations" do
    it { should validate_presence_of(:developer_id) }
    it { should validate_presence_of(:unit_id) }
    it { should validate_presence_of(:due_at) }
    it { should validate_presence_of(:max_score) }
    it { should validate_presence_of(:score) }
  end

  describe "enum scope" do
    it { should define_enum_for(:type) }
  end

  describe "methods" do
    let(:assessment) { {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"2\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"} }

    it "should save with valid json" do
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
      updated_assessment = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
      date = Date.parse(JSON.parse(assessment["assessment"])["due_at"])
      create(:developer)
      cohort = create(:cohort)
      unit = create(:unit, start_at: date.yesterday, end_at: date.tomorrow)
      cohort.units << unit
      Assessment.create_from_google_form(assessment)
      Assessment.create_from_google_form(updated_assessment)
      expect(Assessment.last.score == 1).to be_truthy
    end

    it "should not create duplicate records for the same assessment" do
      updated_assessment = {"assessment"=>"{\"type\":\"0\",\"github_url\":\"\",\"comments\":\"\",\"name\":\"Test Developer\",\"max_score\":\"3\",\"score\":\"1\",\"due_at\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}"}
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
=======
  pending "add some examples to (or delete) #{__FILE__}"
end
>>>>>>> assessment table
