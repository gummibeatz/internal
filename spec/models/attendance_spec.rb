require 'rails_helper'

RSpec.describe Attendance, type: :model do

  let(:developer) { build(:developer) }

  # associations
  it { should belong_to(:developer) }

  # enum scopes
  it { should define_enum_for(:status) }

  it "creates an attendance" do
    expect {
      attendance = create(:attendance, developer: developer)
    }.to change(Attendance, :count).by(1)
  end

  it "only has one record per developer per day" do
    attendance = create(:attendance, developer: developer)
    attendance_two = build(:attendance, developer: developer)
    expect(attendance_two).to_not be_valid
  end

  describe "creating attendances from google forms" do

    ON_TIME = {"attendance"=>"{\"attendance\":{\"name\":\"Test Developer\",\"status\":0,\"date\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}}"}

    it "creates entry from google form" do
      expect {
        create(:developer, full_name: "test developer")
        Attendance.create_from_google_form(ON_TIME)
      }.to change(Attendance, :count).by(1)
    end

    it "doesn't create duplicate entry based on date from google form" do
      late = {"attendance"=>"{\"attendance\":{\"name\":\"Test Developer\",\"status\":2,\"date\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}}"}
      create(:developer, full_name: "test developer")
      Attendance.create_from_google_form(ON_TIME)
      expect {
        Attendance.create_from_google_form(late)
      }.to change(Attendance, :count).by(0)
    end

  end

  describe "attendance emails" do

    TODAY = Date.today

    before(:each) do
      cohort = create(:cohort)
      @developer = create(:developer)
      @developer.build_user(
        email: developer.email,
        password: Devise.friendly_token
      )
      cohort.developers << @developer
      unit = create(:unit)
      cohort.units << unit
      cohort.save!
    end

#    it "should send email when not meeting reqs" do
#      @developer.attendances.create!(status: "late_unexcused_5_minutes", timestamp: TODAY-2)
#      @developer.attendances.create!(status: "late_unexcused_10_minutes", timestamp: TODAY-1)
#      expect{
#        @developer.attendances.create!(status: "late_unexcused_10_minutes", timestamp: TODAY-3)
#      }.to change(Notification, :count).by(1)
#    end
#
#    it "should send email when in danger of not meeting reqs" do
#      expect{
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: TODAY-2)
#        @developer.attendances.create(status: "late_unexcused_10_minutes", timestamp: TODAY-1)
#      }.to change(Notification, :count).by(1)
#    end
#
#    it "should only send email when in danger of not meeting reqs once" do
#      expect{
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp:TODAY-2)
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp:TODAY-1)
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp:TODAY-3)
#      }.to change(Notification.where(kind: "danger"), :count).by(1)
#    end
#
#    it "should only send email when not meeting reqs once" do
#      expect{
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: TODAY-2)
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: TODAY-1)
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: TODAY-3)
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: TODAY-4)
#        @developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: TODAY-5)
#      }.to change(Notification.where(kind: "peril"), :count).by(1)
#    end
  end

  describe :scopes do
    it "returns all records within a range" do
      dates = [Date.today.to_datetime]
      3.times { dates << dates.last.tomorrow }
      out_of_bounds = 20.days.ago.to_datetime
      dates << out_of_bounds
      dates.each { |d| create(:attendance, developer: developer, timestamp: d) }
      range = Range.new(dates.first, dates.last)

      expect(Attendance.in_range(range).include?(out_of_bounds)).to be_falsy
    end
  end

end

# == Schema Information
#
# Table name: attendances
#
#  id           :integer          not null, primary key
#  status       :integer          default(0)
#  developer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  timestamp    :datetime
#
