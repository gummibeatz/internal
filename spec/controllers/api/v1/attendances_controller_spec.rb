require 'rails_helper'

RSpec.describe Api::V1::AttendancesController, type: :controller do
  describe "POST create" do
    it "creates a record with valid json" do
      expect {
        create(:developer, full_name: "test developer")
        on_time = {"attendance"=>"{\"attendance\":{\"name\":\"test developer\",\"status\":0,\"date\":\"Sat, 15 Aug 2015 04:00:00 GMT\"}}"}
        post :create, on_time
      }.to change(Attendance, :count).by(1)
    end

    it "renders 500 with invalid data" do
      expect {
        post :create
      }.to raise_error(Api::V1::InvalidGoogleParamsError)
    end
  end
end
