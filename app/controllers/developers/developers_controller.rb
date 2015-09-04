module Developers
  class DevelopersController < ApplicationController
    layout "developers"

    def index
      @user = current_user.developer
      if request.xhr?
        puts "is"
      else
        puts "not"
      end
    end

    def stats
      render json: {
        attendance: current_user.developer.attendances.stats
      }
    end

  end
end
