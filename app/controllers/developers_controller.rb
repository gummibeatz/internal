class DevelopersController < ApplicationController
  def index
    @developers = Developer.all
  end

  def show
  end

  def new
  end

  def import
    Developer.import(params[:file])
    redirect_to root_url
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
