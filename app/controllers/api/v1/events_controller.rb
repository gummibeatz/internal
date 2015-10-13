module Api
  module V1
    class EventsController < Api::V1::ApiController

      def bash2015_receive_message

        # first time
        response = ""
        if donor.nil?
          if d = SmsDonor.create_from_twilio_response(params)
            d.pledges << SmsPledge.create(amount: params[:Body])
            response = Twilio::TwiML::Response.new do |r|
              r.Sms "Thanks for your donotion! What's your name?"
            end
          end
        elsif donor.messages.count == 1 # second time
          donor.update_attribute(:name, params[:Body])
          response = Twilio::TwiML::Response.new do |r|
            r.Sms "Thanks, #{donor.name}. Would you like to leave a message for C4Q?"
          end
        elsif donor.messages.count == 2 # last time
          donor.pledges.first.update_attribute(:message, params[:Body])
          response = Twilio::TwiML::Response.new do |r|
            r.Sms "You're the best. Enjoy the delicious mochi ice cream :)"
          end
        else
          response = Twilio::TwiML::Response.new do |r|
            r.Sms "Thanks for the donation, #{donor.name}! Have a good time :)"
          end
        end

        donor.messages << SmsDonorMessage.create_message_from_twilio(params)
        render text: response.text
      end

      def bash_2015
        render json: SmsPledge.all.order(created_at: :desc).as_json
      end

      private

      def donor
        @donor if defined?(@donor)
        SmsDonor.where(phone_number: params[:From]).last
      end

    end
  end
end
