class Assignment < ActiveRecord::Base

  enum type: ["homework", "exam", "project"]

  scope :are_active, -> { where(active: true) }

  has_many :assessments
  
  validates :unit_id, presence: true
  validates :due_at, presence: true
  validates :max_score, presence: true
  validates :type, presence: true
  validates :active, inclusion: {in: [true,false]}
  validates :github_url, presence: true

  def self.inheritance_column
    "inheritance_type"
  end

end
