class ExitTicket < ActiveRecord::Base

  belongs_to :developer

  def self.import(file)
    ActiveRecord::Base.transaction do
      ExitTicketImporter.import(file)
    end
  end

  def self.import_from_google_form(form_data)
    json = JSON.parse(form_data["tickets"])
    tickets = json["tickets"]
    tickets.each do |ticket|
      if developer = Developer.where("full_name = ?", ticket["name"]).first
        ticket.delete("name")
        submitted_at = Date.parse(ticket["submitted_at"]).to_datetime
        if t = ExitTicket.where("developer_id = ? AND submitted_at = ?", developer.id, submitted_at).last
          t.update_attributes(ticket)
        else
          t = ExitTicket.new(ticket)
          t.submitted_at = submitted_at
          if t.save
            developer.exit_tickets << t
          end
        end
      end
    end
    puts json.to_yaml
  end

  def self.create_from_google_form(form_data)
    json = JSON.parse(form_data["ticket"])
    tck = json["ticket"]

    ActiveRecord::Base.transaction do
      developer = Developer.where(full_name: tck["name"]).first
        submitted_at = DateTime.now.in_time_zone.midnight
        ticket.delete("name")
        if t = ExitTicket.where("developer_id = ? AND submitted_at = ?", developer.id, submitted_at).last
          t.update_attributes(ticket)
        else
          ticket = ExitTicket.new(ticket)
          ticket.submitted_at = submitted_at
          if ticket.save
            developer.exit_tickets << ticket
          else
            return false
          end
        end
    end

    true
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
#
