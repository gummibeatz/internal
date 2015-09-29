module Api
  module V1
    class AssessmentsController < Api::V1::ApiController
      
      def index
        render json: developer.assessments.as_json
      end

      def create
        if Assessment.create_from_google_form(params)
          head :ok
        else
          raise InvalidGoogleParamsError
        end
      end

      private 

      def developer
        return Developer.find(params[:developer_id]) if params[:developer_id]
        return current_user.developer
      end
      
    end
  end
end
