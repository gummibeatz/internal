class CohortsController < ApplicationController
  def index
    @cohorts = Cohort.includes(:developers).all
  end

  def show
  end

  def new
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

  helper_method :cohort
  def cohort
    @cohort if defined?(@cohort)
    @cohort = Cohort.find(params[:id])
  end
end
