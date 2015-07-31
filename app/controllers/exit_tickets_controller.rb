class ExitTicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:exit_ticket]
  skip_before_filter :authenticate_user!, only: [:exit_ticket]

  def create
    ExitTicket.create_from_google_form(params)
    head :ok
  end

end
