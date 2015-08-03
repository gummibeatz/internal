class Cohort < ActiveRecord::Base

  UNIT_0 = Range.new(Date.parse("20150531").to_datetime, Date.parse("20150702").to_datetime)
  UNIT_1 = Range.new(Date.parse("20150707").to_datetime, Date.parse("20150903").to_datetime)
  UNIT_2 = Range.new(Date.parse("20150908").to_datetime, Date.parse("20151022").to_datetime)
  UNIT_3 = Range.new(Date.parse("20151027").to_datetime, Date.parse("20151210").to_datetime)

  has_many :developers, -> { order(first_name: :asc) }
  has_many :units, -> { order(started_at: :asc) }

  def import(file)
    ActiveRecord::Base.transaction do
      devs = DeveloperImporter.import(file)
      devs.each do |dev|
        developers << dev
      end
    end
  end
end

# == Schema Information
#
# Table name: cohorts
#
#  id         :integer          not null, primary key
#  version    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
