require 'rails_helper'

RSpec.describe Api::V1::AttendancesController, type: :controller do
  render_views
  describe "POST create" do
    it "creates an attendance record with valid data" do
      expect {
        create(:c4q_developer, full_name: "test developer")
        on_time = {"attendance"=>"{\"attendance\":{\"name\":\"test developer\",\"status\":0,\"date\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}}"}
        post :create, on_time
      }.to change(Attendance, :count).by(1)
    end

    it "renders 500 with invalid data" do
      expect {
        post :create
      }.to raise_error(Api::V1::AttendancesController::InvalidOauthParamsError)
    end
  end
end
