class Cohort < ActiveRecord::Base

  has_many :developers

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
