module Api
  module V1
    class DevelopersController < Api::V1::ApiController

       def show
         # includes all the table values for units, developers and users who are developers  
         cohort = Cohort.includes(:units,developers:[:user]).where('developer_id = ?', current_user.developer.id).references(:user).first 
         render json: {
           developer: current_user.developer.as_json,
           cohort: {
             cohort: cohort.as_json,
             units: cohort.units.map(&:as_json)
           }
         }
       end

       private

      def developer
        @developer if defined?(@developer)
        @developer = Developer.find(params[:id])
      end

    end
  end
end
