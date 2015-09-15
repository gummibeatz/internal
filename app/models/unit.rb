class Unit < ActiveRecord::Base

  belongs_to :cohort
  has_many :assessments

  def range
    Range.new(start_at, end_at)
  end

  def contains_date?(date)
    start_at <= date && end_at >= date
  end

end

# == Schema Information
#
# Table name: units
#
#  id         :integer          not null, primary key
#  start_at   :datetime
#  end_at     :datetime
#  cohort_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  index      :integer
#
