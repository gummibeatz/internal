class UnitsController < ApplicationController
  def show
    @index = unit.cohort.units.index(unit)

    #TODO this only works for the current unit
    @percentage_complete = (((Date.today - unit.range.begin.to_date).to_i / (unit.range.end.to_date - unit.range.begin.to_date).to_f) * 100).round(2)

    # exit tickets
    et_all = ExitTicket.where("submitted_at >= ? and submitted_at <= ?", unit.range.begin, unit.range.end)
    @et_completion_rate = ExitTicket.completion_rate_in_range(unit.range)
    @et_accuracy_rate = ExitTicket.accuracy_rate_in_range(unit.range)
    @et_unscored = et_all.technical.where(score: nil).count

    # attendance
    all_in_unit = Attendance.where("timestamp >= ? and timestamp <= ?", unit.range.begin, unit.range.end)
    @attendance_rate = all_in_unit.present.count / all_in_unit.count.to_f
    @on_time = 1 - all_in_unit.late.count / all_in_unit.present.count.to_f
  end

  private

  helper_method :unit
  def unit
    @unit if defined?(@unit)
    @unit = Unit.find(params[:id])
  end
end
