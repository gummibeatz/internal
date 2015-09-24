class Assessment < ActiveRecord::Base

  enum type: ["homework", "exam", "project"]

  scope :most_recent, -> { order(:updated_at).last }
  scope :active_assignments, -> { includes(:assignment).where('assignments.active' => 'true').references(:assignment) }

  belongs_to :developer
  belongs_to :assignment

  validates :developer_id, presence: true
  validates :assignment_id, presence: true
  validates :due_at, presence: true
  validates :max_score, presence: true
  validates :score, presence: true
  validates :type, presence: true

  # after_save :send_report

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

  def send_report
    unless self.developer.user.nil?
      @notification = Notification.create!(
        user: self.developer.user,
        email: self.developer.email,
        subject_type: "User",
        email_from: "c4qDevPortal@test.com",
        email_subject: "Assessment for Assignment #{self.assignment.id}",
        kind: "assessment_report"
      )
      @notification.deliver
    end
  end

  private

  def self.update_or_create(json)
    developer = Developer.where(full_name: json["name"].downcase).first
    date = Date.parse(json["due_at"]).to_datetime.midnight
    assignment = Assignment.where(github_url: json["github_url"]).first
    if assessment = Assessment.where("developer_id = ? and assignment_id = ? and due_at = ?", developer.id, assignment.id, date).first
      assessment.update_attributes(score: json["score"])
      return true
    else
      developer.assessments.create(
        assignment_id: assignment.id,
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
