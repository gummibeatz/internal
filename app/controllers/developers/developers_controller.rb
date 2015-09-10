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
        attendances: current_user.developer.attendances.as_json,
        assessments: current_user.developer.assessments.as_json
      }
      @user = current_user.developer
    end

  end
end
