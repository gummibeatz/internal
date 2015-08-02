class ExitTicket < ActiveRecord::Base

  belongs_to :developer

  # Submitted as Google Form
  def self.create_from_google_form(form_data)
    json = JSON.parse(form_data["ticket"])
    tck = json["ticket"]

    ActiveRecord::Base.transaction do
      developer = Developer.where(full_name: tck["name"]).first
        tck["submitted_at"] = Date.parse(tck["submitted_at"]).to_datetime
        tck.delete("name")
        tck["questions"] = tck["questions"].to_json
        if t = ExitTicket.where("developer_id = ? AND submitted_at = ?", developer.id, tck["submitted_at"]).last
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
      ExitTicketImporter.import(file)
    end
  end

  # Submitted as exit ticket response sheet
  def self.import_from_google_form(form_data)
    ActiveRecord::Base.transaction do
      ExitTicketImporter.import(form_data)
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
#
