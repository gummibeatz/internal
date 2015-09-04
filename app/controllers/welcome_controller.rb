class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!

  layout "welcome"

  def index
    if current_user
      if current_user.developer?
        redirect_to '/developers/'
      else
        redirect_to '/admin/developers'
      end
    end
  end

end
