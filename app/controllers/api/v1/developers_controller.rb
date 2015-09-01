module Api
  module V1
    class DevelopersController < ApiController

       def show
         render json: developer.to_json
       end

       private

      def developer
        @developer if defined?(@developer)
        @developer = Developer.find(params[:id])
      end

    end
  end
end
