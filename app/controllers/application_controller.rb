class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_url, :notice => 'You must be authenticated'
    end
  end
end
