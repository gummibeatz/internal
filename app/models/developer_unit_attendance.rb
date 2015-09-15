class DeveloperUnitAttendance

  attr_accessor :range, :developer, :attendances

  def initialize(developer, range)
    @developer = developer
    @range = range
    @attendances = @developer.attendances.in_range(range)
  end

  def late
    @attendances.late
  end

  def absent
    @attendances.absent
  end

end
