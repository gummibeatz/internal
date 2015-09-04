module Api
  module V1
    class AttendancesController < Api::V1::ApiController
      def create
        if attendance = Attendance.create_from_google_form(params)
          head :ok
        else
          raise Api::V1::InvalidGoogleParamsError
        end
      end

      def import_all
        Attendance.import_all(params)
        head :ok
      end
    end
  end
end

