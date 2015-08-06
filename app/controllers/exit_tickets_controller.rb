class ExitTicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :import, :grade]
  skip_before_filter :authenticate_user!, only: [:create, :import, :grade]

  def index
	  # TODO: not verifying auth token?
	  if request.xhr?
		  render json: ExitTicket.all.as_json
	  end
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
    json = JSON.parse(params["exit_ticket"])
    t = json["ticket"]
    if developer = Developer.where(full_name: t["name"].downcase).first
      date = Date.parse(t["date"]).to_datetime
      if ticket = developer.exit_tickets.where(submitted_at: date, type: t["type"]).first
        ticket.update_attribute(:score, t["score"])
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

