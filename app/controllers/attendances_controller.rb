class AttendancesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_filter :authenticate_user!, only: [:create]

  def create
    Attendance.create_from_google_form(params)
    head :ok
  end
end
