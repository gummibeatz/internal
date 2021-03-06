class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user! unless Rails.env.development?

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_url, :notice => 'You need to be signed in to do that'
    end
  end

  def require_admin!
    redirect_to root_url, :notice => 'You must be an admin to do that' if (current_user && current_user.developer?) || !current_user
  end
end
