class ExitTicket < ActiveRecord::Base

  self.inheritance_column = "inheritance_type"

  enum type: [:technical, :nontechnical]

  belongs_to :developer

  def self.completion_rate_in_range(range)
    tickets = self.all_in_range(range).technical
    timestamps = tickets.map(&:submitted_at).uniq
    attendance = Attendance.where("timestamp in (?)", timestamps).present
    return (tickets.count / attendance.count.to_f) unless count == 0
    return -1
  end

  def self.completion_rate_on_day(day)
    attendance = Attendance.where("timestamp = ?", day).present
    tickets = where(submitted_at: day).technical
    return (tickets.count / attendance.count.to_f) unless tickets.count == 0
    return -1
  end

  def self.accuracy_rate_in_range(range)
    tickets = self.all_in_range(range).technical
    return tickets.map(&:score).inject(0.0) { |sum, el| sum + (el || 0) }.to_f / tickets.count unless tickets.count == 0
    return -1
  end

  def self.accuracy_rate_on_day(day)
    tickets = where(submitted_at: day)
    return tickets.map(&:score).inject(0.0) { |sum, el| sum + (el || 0) }.to_f / tickets.count unless tickets.count == 0
    return -1
  end

  def self.all_in_range(range)
    self.where("submitted_at >= ? AND submitted_at <= ?", range.begin, range.end)
  end

  # Submitted as Google Form
  def self.create_from_google_form(form_data)
    json = JSON.parse(form_data["ticket"])
    tck = json["ticket"]

    ActiveRecord::Base.transaction do
      developer = Developer.where(full_name: tck["name"].downcase).first
        tck["submitted_at"] = Date.parse(tck["submitted_at"]).to_datetime
        tck.delete("name")
        tck["questions"] = tck["questions"].to_json
        if t = ExitTicket.where("developer_id = ? and submitted_at = ? and type = ?", developer.id, tck["submitted_at"], (tck["type"] || 0)).last
          t.update_attributes(tck)
        else
          ticket = ExitTicket.new(tck)
          if ticket.save
            developer.exit_tickets << ticket
          else
            return false
          end
        end
    end

    true
  end

  # Imported as .csv
  def self.import(file)
    ActiveRecord::Base.transaction do
      ExitTicketImporter.import_from_file(file)
    end
  end

  # Submitted as exit ticket response sheet
  def self.import_from_google_form(form_data)
    ActiveRecord::Base.transaction do
      ExitTicketImporter.import_from_form(form_data)
    end
  end

end

# == Schema Information
#
# Table name: exit_tickets
#
#  id                                     :integer          not null, primary key
#  certainty                              :integer          default(0)
#  overall_quality                        :integer          default(0)
#  difficulty                             :integer          default(0)
#  instructors_ability_to_communicate     :integer          default(0)
#  instructors_ability_to_stimulate       :integer          default(0)
#  pace_and_speed                         :integer          default(0)
#  understanding                          :integer          default(0)
#  recall_information_from_previous_class :integer          default(0)
#  additional_comments                    :string
#  developer_id                           :integer
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#  original_form_url                      :string
#  submitted_at                           :datetime
#  questions                              :text
#  score                                  :float
#  summary_form_url                       :string
#  type                                   :integer          default(0)
#
