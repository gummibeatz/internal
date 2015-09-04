module Api
  module V1
    class AssessmentsController < Api::V1::ApiController
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
