class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :authenticate_user!

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def github
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user && @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Github"
      sign_in @user
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  private

  def from_oauth
  end

end
