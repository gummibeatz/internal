class ExitTicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :import]
  skip_before_filter :authenticate_user!, only: [:create, :import]

  def index
      @exit_tickets = ExitTicket.all.sort_by(&:submitted_at).reverse.group_by(&:submitted_at).sort_by
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

  def grade
    json = JSON.parse(form_data["exit_ticket"])
    att = json["ticket"]
    if developer = Developer.where(full_name: json["name"].downcase).first
      date = Date.parse(json["date"]).to_datetime
      if ticket = ExitTicket.where(submitted_at: date).first
        ticket.update_attributes(:score, json["score"])
        head :ok
      else
        render status: 500
      end
    else
      render status: 500
    end
  end

  protected

  helper_method :exit_ticket
  def exit_ticket
    @exit_ticket if defined?(@exit_ticket)
    @exit_ticket = ExitTicket.includes(:developer).find(params[:id])
  end

end

