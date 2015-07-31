class ExitTicket < ActiveRecord::Base

  belongs_to :developer

  def self.create_from_google_form(form_data)
    json = JSON.parse(form_data["ticket"])
    ticket = json["ticket"]
    puts "*" * 80
    puts ticket["overall_quality"]
    puts ticket["difficulty"]
    puts ticket["name"]
    puts "*" * 80
  end

end
