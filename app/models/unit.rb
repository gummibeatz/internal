class Unit < ActiveRecord::Base

  belongs_to :cohort

  def range
    Range.new(started_at, ended_at)
  end

end

# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  started_at :datetime
#  ended_at   :datetime
#  cohort_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
