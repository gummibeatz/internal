module Developers
  class DevelopersController < ApplicationController
    layout "developers"

    def index
      @user = current_user.developer
      if request.xhr?
      end
    end

  end
end
