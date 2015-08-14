class Report
	
	attr_accessor :range
	
	# constructor
	def initialize(start, finish)
		@range = Range.new(start,finish)
	end
	
	def exit_ticket_completion_rate
		return ExitTicket.completion_rate_in_range(self.range)
	end
	
	def exit_ticket_accuracy_rate
		return ExitTicket.accuracy_rate_in_range(self.range)
	end
	
	def attendance_present_rate
		return Attendance.rate_in_range(self.range)
	end
	
	def attendance_late_rate
		return Attendance.percentage_late_in_range(self.range)
	end
	
	def attendance_on_time_rate
		return Attendance.percentage_on_time_in_range(self.range)
	end


end
