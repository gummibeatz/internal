module Api
  module V1
    class AttendancesController < Api::V1::ApiController
      def index
        render json: developer.attendances.order(timestamp: :desc).as_json
      end

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

      private

      def developer
        return Developer.find(params[:developer_id]) if params[:developer_id]
        return current_user.developer
      end
      
    end
  end
end

