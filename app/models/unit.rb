class Unit < ActiveRecord::Base

  belongs_to :cohort

  def range
    Range.new(started_at, ended_at)
  end

end
