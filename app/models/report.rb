class Report
	
	attr_accessor :range
	
	# constructor
	def initialize(start, finish)
		:range = Range.new(start,finish)
	end
	
	
	# below: mostly copied from exit_ticket.rb and attendance.rb
	
	# percent submitted
	def self.completion_rate_in_range
		tickets = self.all_in_range(:range).technical
    	timestamps = tickets.map(&:submitted_at).uniq
    	attendance = Attendance.where("timestamp in (?)", timestamps).present
    	return (tickets.count / attendance.count.to_f) unless count == 0
    	return -1
  	end
	
	# percent accurate
	def self.accuracy_rate_in_range
		tickets = self.all_in_range(:range).technical
    	return tickets.map(&:score).inject(0.0) { |sum, el| sum + (el || 0) }.to_f / tickets.count unless tickets.count == 0
    	return -1
  	end


	# percent present
	def self.rate_in_range
    	all = self.all_in_range(:range)
    	return all.present.count / all.count.to_f unless all.count == 0
    	return -1
  	end

	# percent late
  	def self.percentage_late_in_range
		all = self.all_in_range(:range)
    	present = all.present
    	late = all.late
    	late.count.to_f / present.count
  	end

	# percent on time
  	def self.percentage_on_time_in_range
		1 - self.percentage_late_in_range(:range)
  	end
	
	
	
	
end