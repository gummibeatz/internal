class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :require_admin!

  def index
  end

end
