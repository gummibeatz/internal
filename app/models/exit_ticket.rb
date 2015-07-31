class ExitTicket < ActiveRecord::Base

  belongs_to :developer

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
