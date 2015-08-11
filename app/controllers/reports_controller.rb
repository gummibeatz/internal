class ReportsController < ApplicationController

  def index
    if request.xhr?
      range = Range.new(Date.parse(params[:start]).to_datetime, Date.parse(params[:end]).to_datetime)
      render json: {
        exit_tickets: ExitTicket.all_in_range(range),
        attendance: Attendance.all_in_range(range)
      }
    end
  end

end
