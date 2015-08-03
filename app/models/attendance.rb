class Attendance < ActiveRecord::Base

  #TODO
  # This model currently relies on the created_at timestamp
  # to determine the date of attendance. This may or may not
  # cause problems in the future

  enum status: [:on_time, :excused_lateness, :late_5_minues, :late_10_minutes, :absence_excused, :absence_unexcused]

  belongs_to :developer

  def self.find_or_create(json)
    developer = Developer.where(full_name: json["name"].downcase).first

    date = Date.parse(json["date"]).to_datetime.midnight
    if attendance = Attendance.where("timestamp = ? AND developer_id = ?", date , developer.id).first
      attendance.update_attribute(:status, json["status"])
    else
      attendance = developer.attendances.create( status: json["status"], timestamp: date)
    end
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

# == Schema Information
#
# Table name: attendances
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  developer_id :integer
#  status       :integer          default(0)
#
