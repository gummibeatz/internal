class AttendancesController < ApplicationController
  def create
    Attendance.create_from_google_form(params)
    head :ok
  end
end
