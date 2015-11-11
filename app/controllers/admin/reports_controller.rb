module Admin
  class ReportsController < Admin::AdminController


# need to add in some way to 
# do exit tickets by cohort

    def index
      if params[:start_date].present? && params[:end_date].present?
        range = Range.new(Date.parse(params[:start_date]).to_datetime, Date.parse(params[:end_date]).to_datetime)
        if request.xhr?
          render json: {
            exit_tickets: ExitTicket.in_range(range),
            attendance: Attendance.in_range(range)
          }
        else
          @report = Report.new(range.begin, range.end)
        end
      end
    end

  end
end
