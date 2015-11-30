module Admin
  class DevelopersController < Admin::AdminController

    def index
      @cohorts = Cohort.all
    end

    def dashboard

    end

    def show
    end

    def new
    end

    def import
      cohort = Cohort.find(params[:cohort_id])
      cohort.import(params[:file])
      redirect_to developers_path
    end

    def create
    end

    def update
      if developer.update_attributes(developer_params)
        redirect_to :action => "show", :id => developer.id
      else
        redirect 'edit'
      end
    end

    def edit
      @developer = developer
    end

    def destroy
    end

    protected

    def developer_params
      params.require(:developer).permit(:first_name, :last_name, :email, :github_username, :phone, :apple_id)
    end

    helper_method :developer
    def developer
      return @developer if defined?(@developer)
      @developer = Developer.includes(:exit_tickets).find(params[:id])
    end

  end
end
