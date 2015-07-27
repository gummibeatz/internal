class UsersController < ApplicationController

  def google_oauth2
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication
      else
        flash[:error] = @user.errors.full_messages
        redirect_to root_path
      end
  end

end
