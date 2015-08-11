class Attendance < ActiveRecord::Base

  enum status: [:on_time, :late_excused, :late_unexcused_5_minues, :late_unexcused_10_minutes, :absent_excused, :absent_unexcused]

  scope :present, -> { where("status != 4 AND status != 5") }
  scope :absent,  -> { where("status = 4 OR status = 5") }
  scope :late,    -> { where("status = 1 OR status = 2 OR status = 3") }
  scope :on_time, -> { where ("status = 0") }

  belongs_to :developer

  def self.rate_in_range(range)
    all = self.all_in_range(range)
    return all.present.count / all.count.to_f unless all.count == 0
    return -1
  end

  def self.percentage_late_in_range(range)
    all = self.all_in_range(range)
    present = all.present
    late = all.late
    late.count.to_f / present.count
  end

  def self.percentage_on_time_in_range(range)
    1 - self.percentage_late_in_range(range)
  end

  def self.all_in_range(range)
    where("timestamp >= ? and timestamp <= ?", range.begin, range.end)
  end

  def self.rate_on_day(day)
    where("timestamp = ?", day).present.count / 32.0
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
#  status       :integer          default(0)
#  developer_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  timestamp    :datetime
#
