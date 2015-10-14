module Api
  module V1
    class SlackApiController < Api::V1::ApiController
      def index
        if params.has_key?(:developer_id)
          developer = Developer.find(params[:developer_id])
          date = getActiveAssignmentDate(developer)
          result = getChannelFeedWithDate(date)
          render json: JSON.parse(result)["messages"]
        end
      end

      private
     
      def getActiveAssignmentDate(developer)
        date = developer.cohort.assignments.active.first.created_at 
      end

      def getChannelFeedWithDate(date)
        token = Rails.application.secrets.slack_access_code_2_2_token
        channel_id = "C0569TDLH"
        uri = URI("https://slack.com/api/channels.history?token=#{token}&&channel=#{channel_id}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri.request_uri)
        request.initialize_http_header(headers)
        response = http.request(request)
        response.body
      end
      
    end
  end
end

