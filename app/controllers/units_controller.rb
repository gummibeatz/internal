class UnitsController < ApplicationController
  def show
    @index = unit.cohort.units.index(unit)

    #TODO this only works for the current unit
    @percentage_complete = (((Date.today - unit.range.begin.to_date).to_i / (unit.range.end.to_date - unit.range.begin.to_date).to_f) * 100).round(2)

    # exit tickets
    @et_completion_rate = (ExitTicket.completion_rate_in_range(unit.range) * 100).round(2)
    @et_accuracy_rate = (ExitTicket.accuracy_rate_in_range(unit.range) * 100).round(2)

    # attendance
    all_in_unit = Attendance.where("timestamp >= ? and timestamp <= ?", unit.range.begin, unit.range.end)
    present = all_in_unit.present
    @attendance_rate = ((present.count / all_in_unit.count.to_f) * 100).round(2)
    @on_time = 100 - ((all_in_unit.late.count / present.count.to_f) * 100).round(2)
  end

  private

  helper_method :unit
  def unit
    @unit if defined?(@unit)
    @unit = Unit.find(params[:id])
  end
end
