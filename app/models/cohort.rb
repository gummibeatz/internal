class Cohort < ActiveRecord::Base

  has_many :developers, -> { order(first_name: :asc) }
  has_many :units, -> { order(start_at: :asc) }

  validates :version, uniqueness: true

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
