module Api
  module V1
    class DevelopersController < Api::V1::ApiController

       def show
         @developer = current_user.developer
       end

       private

      def developer
        @developer if defined?(@developer)
        @developer = Developer.find(params[:id])
      end

    end
  end
end
