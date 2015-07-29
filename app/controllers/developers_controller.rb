class DevelopersController < ApplicationController
  def index
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

end
