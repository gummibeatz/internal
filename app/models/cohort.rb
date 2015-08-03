class Cohort < ActiveRecord::Base

  has_many :developers, -> { order(first_name: :asc) }

  def create_developer_association(devs)
    devs.each do |dev|
      developers << dev
    end
  end

  def import(file)
    ActiveRecord::Base.transaction do
      devs = DeveloperImporter.import(file)
      create_developer_association(devs)
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
