class ExitTicket < ActiveRecord::Base

  scope :in_range, -> (range) { where("submitted_at >= ? AND submitted_at <= ?", range.begin, range.end) }
  scope :unscored, -> { where("score is null") }

  enum type: [:technical, :nontechnical]

  belongs_to :developer

  validate :one_per_day_per_developer, on: :create

  def self.inheritance_column
    "inheritance_type"
  end

  def self.completion_rate
    tickets = all.technical
    timestamps = all.technical.map(&:submitted_at).uniq
    unless timestamps.empty?
      attendance = Attendance.where("timestamp in (?)", timestamps).present
      return (tickets.count / attendance.count.to_f) unless count == 0
    end
    -1
  end

  def self.accuracy_rate
    tickets = all.technical
    return tickets.map(&:score).inject(0.0) { |sum, el| sum + (el || 0) }.to_f / tickets.count unless tickets.count == 0
    -1
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

  private

  def one_per_day_per_developer
    if ExitTicket.where(developer_id: developer_id, submitted_at: submitted_at).first.present?
      errors.add(:exit_ticket, "An exit ticket record already exists for this developer (#{developer_id}) on #{submitted_at}")
    end
  end

end

# == Schema Information
#
# Table name: exit_tickets
#
#  id                :integer          not null, primary key
#  certainty         :integer          default(0)
#  quality           :integer          default(0)
#  difficulty        :integer          default(0)
#  communication     :integer          default(0)
#  stimulation       :integer          default(0)
#  pace_and_speed    :integer          default(0)
#  understanding     :integer          default(0)
#  recall            :integer          default(0)
#  comments          :string
#  developer_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  original_form_url :string
#  submitted_at      :datetime
#  questions         :text
#  score             :float
#  summary_form_url  :string
#  type              :integer          default(0)
#
