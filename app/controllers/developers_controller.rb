class DevelopersController < ApplicationController

  def index
    @cohorts = Cohort.includes(:developers).all
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
  end

  def edit
  end

  def destroy
  end
	
	def eouStats
		#just testing out unit 1
		start_date = Date.parse("07-07-2015").to_datetime
		end_date = Date.parse("30-08-2015").to_datetime
		range = Range.new(start_date, end_date)
		
		#get all attendacne records for that dev (specified in url)
		@dev_all_attendances = Developer.find(params[:id]).attendances.where("timestamp >= ? and timestamp <= ?", range.begin, range.end)
		dev_all_tickets = ExitTicket.where("developer_id = ? and timestamp >= ? and timestamp <= ?",params[:id], range.begin, range.end)

		
		#render json with attendance information
		render json: {
			num_present: dev_all_attendances.present.count,
			num_absent: dev_all_attendances.absent.count,
			num_late: dev_all_attendances.late.count,
			num_on_time: dev_all_attendances.on_time.count
		}
	
	end
	

  protected

  helper_method :developer
  def developer
    return @developer if defined?(@developer)
    @developer = Developer.includes(:exit_tickets).find(params[:id])
  end

end
