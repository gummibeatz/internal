class Attendance < ActiveRecord::Base

  enum status: [:on_time, :excused_lateness, :late_5_minues, :late_10_minutes, :absence_excused, :absence_unexcused]

  belongs_to :developer

  def self.create_from_goog_form(form_data)
    json = JSON.parse(form_data["attendance"])
    att = json["attendance"]

    ActiveRecord::Base.transaction do
      developer = Developer.where(full_name: att["name"]).first
      attendance = Attendance.new(
        status: att["status"]
      )
      if attendance.save
        developer.attendances << attendance
      else
        return false
      end
    end

    true
  end

end
