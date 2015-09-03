module Admin
  class ExitTicketsController < AdminController
    def index
      # TODO: not verifying auth token?
      if request.xhr?
        render json: ExitTicket.all.as_json
      end
    end

    def show
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
end
