module Developers
  class DevelopersController < ApplicationController
    layout "developers"

    def index
      @user = current_user.developer
      if request.xhr?
        puts "is xhr"
      else
        puts "not xhr"
      end
    end

    def stats
      render json: {
        attendance: current_user.developer.attendances.stats,
        assessments: current_user.developer.assessments.stats
      }
    end

  end
end
