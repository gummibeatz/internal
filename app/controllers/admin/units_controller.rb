module Admin
  class UnitsController < Admin::AdminController
    def show
      @index = unit.cohort.units.index(unit)

      #TODO this only works for the current unit
      @percentage_complete = (((Date.today - unit.range.begin.to_date).to_i / (unit.range.end.to_date - unit.range.begin.to_date).to_f) * 100).round(2)

      # exit tickets
      @report = Report.new(unit.range.begin, unit.range.end)
    end

    private

    helper_method :unit
    def unit
      @unit if defined?(@unit)
      @unit = Unit.find(params[:id])
    end
  end
end
