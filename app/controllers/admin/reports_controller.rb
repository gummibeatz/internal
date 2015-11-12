module Admin
  class ReportsController < Admin::AdminController


# need to add in some way to 
# do exit tickets by cohort

    def index
      if params[:start_date].present? && params[:end_date].present? && params[:cohort_version]
        range = Range.new(Date.parse(params[:start_date]).to_datetime, Date.parse(params[:end_date]).to_datetime)

        developers = Cohort.includes(:developers).where(version: params[:cohort_version]).first.developers
        #NEED TO FIX
        @exit_tickets = ExitTicket.in_range(range).where(developer_id: developers) 
        @attendance = Attendance.in_range(range).where(developer_id: developers)
        if request.xhr?
          render json: {
            exit_tickets: exit_tickets,
            attendance: attendance
       #     exit_tickets: ExitTicket.in_range(range),
       #     attendance: Attendance.in_range(range)
          }
        else
          @report = Report.new(range.begin, range.end, @exit_tickets, @attendance)
        end
      end
    end

  end
end
