module Developers
  class DevelopersController < ApplicationController
    layout "developers"

    def index
      @developer = current_user.developer
    end

    def stats
      render json: {
        attendances: current_user.developer.attendances.as_json,
        assessments: current_user.developer.assessments.as_json
      }
      @developer = current_user.developer
    end

  end
end
