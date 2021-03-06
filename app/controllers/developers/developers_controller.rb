require 'uri'
require 'net/http'

module Developers
  class DevelopersController < ApplicationController

    layout "developers"

    def index
      @developer = current_user.developer
      cohort = @developer.cohort
      unless @developer.cohort.current_unit.nil? 
        @unit_attendances = DeveloperUnitAttendance.new(@developer, @developer.cohort.current_unit.range)
      end
      @evaluations = @developer.evaluations
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
