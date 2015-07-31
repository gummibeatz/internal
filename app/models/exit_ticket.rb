class ExitTicket < ActiveRecord::Base

  belongs_to :developer

  def self.create_from_google_form(form_data)
    json = JSON.parse(form_data["ticket"])
    ticket = json["ticket"]

    ActiveRecord::Base.transaction do
      puts ticket["name"]
      developer = Developer.where(full_name: ticket["name"]).first
      ticket = ExitTicket.new(
        certainty: ticket["certainty"],
        overall_quality: ticket["overall_quality"],
        difficulty: ticket["difficulty"],
        instructors_ability_to_communicate: ticket["instructors_ability_to_communicate"],
        instructors_ability_to_stimulate: ticket["instructors_ability_to_stimulate"],
        pace_and_speed: ticket["pace_and_speed"],
        understanding: ticket["understanding"],
        recall_information_from_previous_class: ticket["recall_information_from_previous_class"],
        additional_comments: ticket["additional_comments"]
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
