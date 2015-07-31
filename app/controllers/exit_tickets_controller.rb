class ExitTicketsController < ApplicationController

  def create
    ExitTicket.create_from_google_form(params)
  end

end
