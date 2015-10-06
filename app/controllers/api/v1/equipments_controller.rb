module Api
  module V1
    class EquipmentsController < Api::V1::ApiController
      def index
        render json: developer.equipments
      end

      def developer
        return Developer.find(params[:developer_id]) if params[:developer_id]
        return current_user.developer
      end
      
    end
  end
end

