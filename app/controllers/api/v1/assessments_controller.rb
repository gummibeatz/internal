module Api
  module V1
    class AssessmentsController < Api::V1::ApiController
      def index
        render json: current_user.developer.assessments.as_json
      end

      def create
        if Assessment.create_from_google_form(params)
          head :ok
        else
          raise InvalidGoogleParamsError
        end
      end
    end
  end
end
