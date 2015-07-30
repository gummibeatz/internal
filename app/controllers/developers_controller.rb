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

  protected

  helper_method :developer
  def developer
    return @developer if defined?(@developer)
    @developer = Developer.find(params[:id])
  end

end
