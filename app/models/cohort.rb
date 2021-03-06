class Cohort < ActiveRecord::Base

  has_many :developers, -> { order(first_name: :asc) }
  has_many :units, -> { order(start_at: :asc) }
  has_many :assignments

  validates :version, uniqueness: true

  def import(file, isAndroid = false)
    ActiveRecord::Base.transaction do
      importer = DeveloperImporter
      devs = isAndroid ? importer.import_android(file) : importer.import(file)
      devs.each do |dev|
        developers << dev
      end
    end
  end

  def current_unit
    unit = units.select { |unit| unit.contains_date?(Date.today) }.first
  end

  def active_assignments
    assignments.active
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
