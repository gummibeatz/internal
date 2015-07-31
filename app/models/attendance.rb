class Attendance < ActiveRecord::Base

  #TODO
  # This model currently relies on the created_at timestamp
  # to determine the date of attendance. This may or may not
  # cause problems in the future

  enum status: [:on_time, :excused_lateness, :late_5_minues, :late_10_minutes, :absence_excused, :absence_unexcused]

  belongs_to :developer

  def self.find_or_create(json)
    developer = Developer.where(full_name: json["name"]).first

    # TODO: 12 hours is arbitrary. The idea is that any attendance record within
    # the last 12 hours would be and update vs create
    if attendance = Attendance.where("created_at < ? AND developer_id = ?", 12.hours.ago, developer.id)
      attendance.update_attribute(:status, json["status"])
    else
      attendance = Attendance.create( status: json["status"])
      developer.attendances << attendance
  end

  def self.create_from_google_form(form_data)
    json = JSON.parse(form_data["attendance"])
    att = json["attendance"]

    ActiveRecord::Base.transaction do
      attendance = Attendance.find_or_create(att)
    end

    true
  end

end
