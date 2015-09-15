class Assessment < ActiveRecord::Base

  enum type: ["homework", "exam", "project"]

  scope :active_assignments, -> { includes(:assignment).where('assignments.active' => 'true').references(:assignment) }  

  belongs_to :unit
  belongs_to :developer
  belongs_to :assignment

  validates :developer_id, presence: true
  validates :unit_id, presence: true
  validates :due_at, presence: true
  validates :max_score, presence: true
  validates :score, presence: true
  validates :type, presence: true

  def self.inheritance_column
    "inheritance_type"
  end

  def self.create_from_google_form(form_data)
    begin
      json = JSON.parse(form_data["assessment"])
      return true if Assessment.update_or_create(json)
    rescue
      false
    end
  end

  def self.stats
  end

  def pretty_due_date
    date = due_at
    date.strftime("%B %d, %Y")
  end

  private

  def self.update_or_create(json)
    developer = Developer.where(full_name: json["name"].downcase).first
    date = Date.parse(json["due_at"]).to_datetime.midnight
    unit = Cohort.first.units.select { |u| u.contains_date?(date) }.first
    if assessment = Assessment.where("developer_id = ? and unit_id = ? and due_at = ?", developer.id, unit.id, date).first
      assessment.update_attributes(score: json["score"])
      return true
    else
      developer.assessments.create(
        unit_id: unit.id,
        due_at: date,
        comments: json["comments"],
        github_url: json["github_url"],
        score: json["score"],
        max_score: json["max_score"],
        type: json["type"].to_i
      )
      return true
    end
  end

end

# == Schema Information
#
# Table name: assessments
#
#  id            :integer          not null, primary key
#  max_score     :float
#  score         :float
#  developer_id  :integer
#  github_url    :string
#  due_at        :datetime
#  unit_id       :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type          :integer
#  comments      :text
#  assignment_id :integer
#
