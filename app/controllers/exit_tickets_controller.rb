class ExitTicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :import]
  skip_before_filter :authenticate_user!, only: [:create, :import]

  def index
      @exit_tickets = ExitTicket.all.sort_by(&:submitted_at).group_by(&:submitted_at).sort_by
  end

  def show
  end

  def create
    ExitTicket.create_from_google_form(params)
    head :ok
  end

  def import
    ExitTicket.import_from_google_form(params)
    head :ok
  end

  def upload
    ExitTicket.import(params[:file])
    redirect_to exit_tickets_path
  end

  protected

  helper_method :exit_ticket
  def exit_ticket
    @exit_ticket if defined?(@exit_ticket)
    @exit_ticket = ExitTicket.includes(:developer).find(params[:id])
  end

end

