module Api
  module V1
    class EventsController < Api::V1::ApiController

      def bash2015_receive_message
        message_body = params["Body"]
        from_number = params["From"]
        puts "*" * 80
        puts message_body
        puts from_number
        puts "*" * 80
        render head :ok
      end

    end
  end
end
