class ExitTicket < ActiveRecord::Base

  belongs_to :developer

  def self.import_from_google_form(form_data)
    json = JSON.parse(form_data["tickets"])
    tickets = json["tickets"]
    tickets.each do |ticket|
      if developer = Developer.where("full_name = ?", ticket["name"]).first
        t.delete("name")
        t = ExitTicket.new(ticket)
        t.submitted_at = Date.parse(ticket.submitted_at).to_datetime
        if t.save
          developer.exit_tickets << t
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
      ticket = ExitTicket.new(
        certainty: tck["certainty"],
        overall_quality: tck["overall_quality"],
        difficulty: tck["difficulty"],
        instructors_ability_to_communicate: tck["instructors_ability_to_communicate"],
        instructors_ability_to_stimulate: tck["instructors_ability_to_stimulate"],
        pace_and_speed: tck["pace_and_speed"],
        understanding: tck["understanding"],
        recall_information_from_previous_class: tck["recall_information_from_previous_class"],
        additional_comments: tck["additional_comments"]
      )
      if ticket.save
        developer.exit_tickets << ticket
      else
        return false
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
