module Api
  module V1
    class EventsController < Api::V1::ApiController

      INVALID_AMOUNT_ERROR_MESSAGE = "That doesn't seem like a valid pledge amount. Please enter a number (eg. 100)"


      def bash2015_receive_message

        # throw error if amount isn't a number
        throw_invalid_amount = Proc.new {
          response = Twilio::TwiML::Response.new do |r|
            r.Sms INVALID_AMOUNT_ERROR_MESSAGE
          end
          render text: response.text and return
        }

        response = ""
        if donor.nil?
          begin
            response = sequence(0)
          rescue
            throw_invalid_amount.call
          end
        elsif donor.messages.count == 1 # second time
          response = sequence(1)
        elsif donor.messages.count == 2 # last time
          response = sequence(2)
        elsif donor.messages.count == 3
          response = sequence(3)
        else
          begin
            response sequence(4)
          rescue
            throw_invalid_amount.call
          end
        end

        donor.messages << SmsDonorMessage.create_message_from_twilio(params)
        render text: response.text
      end

      def bash_2015
        render json: SmsPledge.all.order(created_at: :desc).as_json
      end

      def sequence(idx)

          p1 = Proc.new {
            raise "hell" if params[:Body].to_i == 0
            if d = SmsDonor.create_from_twilio_response(params)
              pledge = SmsPledge.create(amount: params[:Body])
              d.pledges << pledge
              response = Twilio::TwiML::Response.new do |r|
                r.Sms ::SmsDonorMessage.bash_messages(0, [pledge.amount])
              end
              return response
            end
          }

          p2 = Proc.new {
            donor.update_attribute(:name, params[:Body])
            response = Twilio::TwiML::Response.new do |r|
              r.Sms ::SmsDonorMessage.bash_messages(1, [donor.name])
            end
            return response
          }

          p3 = Proc.new {
            donor.pledges.first.update_attribute(:message, params[:Body])
            response = Twilio::TwiML::Response.new do |r|
              r.Sms ::SmsDonorMessage.bash_messages(2)
            end
          }

          p4 = Proc.new {
            response = Twilio::TwiML::Response.new do |r|
              r.Sms ::SmsDonorMessage.bash_messages(3, [donor.name])
            end
          }

          p5 = Proc.new {
            raise "hell" if params[:Body].to_i == 0
            donor.pledges << SmsPledge.create(amount: params[:Body])
            response = Twilio::TwiML::Response.new do |r|
              r.Sms ::SmsDonorMessages.bash_messages(4, [donor.name])
            end
          }

          [p1.call, p2.call, p3.call, p4.call, p5.call][idx]
      end

      private

      def donor
        @donor if defined?(@donor)
        SmsDonor.where(phone_number: params[:From]).last
      end

    end
  end
end
