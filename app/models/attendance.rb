class Attendance < ActiveRecord::Base

  enum status: [:on_time, :late_excused, :late_unexcused_5_minutes, :late_unexcused_10_minutes, :absent_excused, :absent_unexcused]

  scope :in_range, -> (range) { where("timestamp >= ? AND timestamp <= ?", range.begin, range.end) }
  scope :present, -> { where("status != 4 and status != 5") }
  scope :absent,  -> { where("status = 4 and status = 5") }
  scope :late,    -> { where("status = 1 or status = 2 or status = 3") }
  scope :on_time, -> { where ("status = 0") }
  scope :late_unexcused, -> { where ("status = 2 or status = 3") }

  belongs_to :developer

  validate :one_per_day_per_developer, on: :create

  validates :status, presence: true

  after_save :check_requirements
  
  def self.percentage_present
    return all.present.count / all.count.to_f unless all.count == 0
    return -1
  end

  def self.percentage_late
    present = all.present
    all.late.count / present.count.to_f
  end

  def self.percentage_on_time
    1 - self.percentage_late
  end

  def self.percentage_late_excused
    late = all.late
    late.late_excused.count / late.count.to_f
  end

  def self.percentage_late_unexcused
    1 - percentage_late_excused
  end

  def self.create_from_google_form(form_data)
    begin
      json = JSON.parse(form_data["attendance"])
      return true if Attendance.update_or_create(json["attendance"])
    rescue
      return false
    end
  end

  def self.import_all(form_data)
    json = JSON.parse(form_data["attendance"])
    as = json["attendance"]

    as.each do |a|
      ActiveRecord::Base.transaction do
        Attendance.find_or_create(a)
      end
    end
  end

  def send_report(report_kind)
    return if self.developer.user.notifications.exists?(kind: report_kind)
    @notification = Notification.create(
        user: self.developer.user,
        email: self.developer.email,
        subject_type: "User",
        email_from: "c4qDevPortal@test.com",
        email_subject: "Graduation requirements",
        kind: "#{report_kind}"
      ).deliver
  end

  def check_requirements
    return unless developer.has_user? and developer.belongs_to_cohort?
    if self.developer.not_meeting_requirements? then send_report("peril") end
    if self.developer.in_danger_of_not_meeting_requirements? then send_report("danger") end
  end


  private

  def self.update_or_create(json)
    developer = Developer.where(full_name: json["name"].downcase).first
    date = Date.parse(json["date"]).to_datetime.midnight
    if attendance = Attendance.where(timestamp: date, developer_id: developer.id).first
      attendance.update_attribute(:status, json["status"])
    else
      attendance = developer.attendances.create( status: json["status"], timestamp: date)
    end
  end

  def one_per_day_per_developer
    if Attendance.where(developer_id: developer_id, timestamp: timestamp).first.present?
      errors.add(:attendance, "An attendance record already exists for this developer (#{developer.id}) on #{timestamp}")
    end
  end

end

# == Schema Information
#
# Table name: attendances
#
#  id           :integer          not null, primary key
#  status       :integer          default(0)
#  developer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  timestamp    :datetime
#
