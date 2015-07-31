class ExitTicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_filter :authenticate_user!, only: [:create]

  def index
    @exit_tickets = ExitTicket.all
  end

  def show
  end

  def create
    ExitTicket.create_from_google_form(params)
    head :ok
  end

  protected

  helper_method :exit_ticket
  def exit_ticket
    @exit_ticket if defined?(@exit_ticket)
    @exit_ticket = ExitTicket.includes(:developer).find(params[:id])
  end

end

