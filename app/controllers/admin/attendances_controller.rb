module Admin
  class AttendancesController < AdminController
    skip_before_action :verify_authenticity_token, only: [:create, :import_all]
    skip_before_filter :authenticate_user!, only: [:create, :import_all]

    def create
      if attendance = Attendance.create_from_google_form(params)
        head :ok
      else
        render status: 500
      end

    end

    def import_all
      Attendance.import_all(params)
      head :ok
    end
  end
end
