class Assessment < ActiveRecord::Base

  enum type: ["homework", "exam", "project"]

  belongs_to :unit
  belongs_to :developer

  validates :developer_id, presence: true
  validates :unit_id, presence: true
  validates :due_at, presence: true
  validates :max_score, presence: true
  validates :score, presence: true

  def self.inheritance_column
    "inheritance_type"
  end

end

# == Schema Information
#
# Table name: assessments
#
#  id           :integer          not null, primary key
#  max_score    :float
#  score        :float
#  developer_id :integer
#  github_url   :string
#  due_at       :datetime
#  unit_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  type         :integer
#
