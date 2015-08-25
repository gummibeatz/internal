class Report

  attr_accessor :range

  # constructor
  def initialize(start, finish)
    @range = Range.new(start, finish)
  end

  def exit_ticket_completion_rate
    return tickets.completion_rate
  end

  def exit_ticket_accuracy_rate
    return tickets.accuracy_rate
  end

  def exit_ticket_unscored
    return tickets.unscored
  end

  def attendance_rate_present
    return attendance.percentage_present
  end

  def attendance_rate_late
    return attendance.percentage_late
  end

  def attendance_rate_on_time
    return attendance.percentage_on_time
  end

  def attendance_rate_late_excused
    return attendance.percentage_late_excused
  end

  def attendance_rate_late_unexcused
    return attendance.percentage_late_unexcused
  end

  private

  def tickets
    @tickets if defined?(@tickets)
    @tickets = ExitTicket.in_range(@range)
  end

  def attendance
    @attendance if defined?(@attendance)
    @attendance = Attendance.in_range(@range)
  end

end
