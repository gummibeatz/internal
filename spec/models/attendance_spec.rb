require 'rails_helper'

RSpec.describe Attendance, type: :model do

  let(:developer) { create(:developer) }

  it { should belong_to(:developer) }

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

end
