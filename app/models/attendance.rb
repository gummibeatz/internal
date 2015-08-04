class Attendance < ActiveRecord::Base

  #TODO
  # This model currently relies on the created_at timestamp
  # to determine the date of attendance. This may or may not
  # cause problems in the future

  enum status: [:on_time, :late_excused, :late_5_minues, :late_10_minutes, :absent_excused, :absent_unexcused]

  belongs_to :developer

  def self.absent
    where("status = 4 OR status = 5")
  end

  def self.late
    where("status = 1 OR status = 2 OR status = 3")
  end

  def self.present
    where("status != 4 AND status != 5")
  end

  def self.rate_in_range(range)
    all = where("timestamp >= ? and timestamp <= ?", range.begin, range.end)
    present = all.present
    return present.count / all.count.to_f
  end

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
      Attendance.find_or_create(att)
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
