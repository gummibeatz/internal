class Assignment < ActiveRecord::Base

  enum type: ["homework", "exam", "project"]

  scope :active, -> { where(active: true) }

  has_many :assessments

  validates :due_at, presence: true
  validates :max_score, presence: true
  validates :type, presence: true
  validates :active, inclusion: {in: [true,false]}
  validates :github_url, presence: true

  def self.inheritance_column
    "inheritance_type"
  end

end

# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  max_score  :integer
#  type       :integer
#  github_url :string
#  due_at     :datetime
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cohort_id  :integer
#
