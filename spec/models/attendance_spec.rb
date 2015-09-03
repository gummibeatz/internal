require 'rails_helper'

RSpec.describe Attendance, type: :model do

  let(:developer) { create(:developer) }

  it { should belong_to(:developer) }

  it "creates an attendance" do
    expect {
      attendance = create(:attendance, developer: developer)
    }.to change(Attendance, :count).by(1)
  end

  it "should validate white list" do

  end

  it "only has one record per developer per day" do
    attendance = create(:attendance, developer: developer)
    attendance_two = build(:attendance, developer: developer)
    expect(attendance_two).to_not be_valid
  end

  it "creates entry from google form" do
    json = {"attendance"=>"{\"attendance\":{\"name\":\"Shena Yoshida\",\"status\":0,\"date\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}}"}
    expect {
      create(:developer, full_name: "shena yoshida")
      Attendance.create_from_google_form(json)
    }.to change(Attendance, :count).by(1)
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
