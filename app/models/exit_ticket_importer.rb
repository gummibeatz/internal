class ExitTicketImporter
  require 'csv'

  MAPPER = {
    "Timestamp" => "submitted_at",
    "Certainty (1-100)" => "certainty",
    "Name" => "name",
    "Correct?" => "score",
    "Assessment Question" => "questions",
    "Please rate the overall quality of the class." => "quality",
    "Please rate the difficulty of the class." => "difficulty",
    "Instructor's ability to communicate the subject matter." => "communication",
    "Instructor's ability to stimulate student interest." => "stimulation",
    "Please rate the pace & speed of the class." => "pace_and_speed",
    "Please rate your understanding of the concepts covered in class." => "understanding",
    "How well do you recall the information taught in the last class?" => "recall",
    "Please list any additional comments about the class/instructor and/or questions for your instructors." => "comments",

    #non-technical
    "Speaker's ability to communicate the subject matter." => "communication",
    "Speaker's ability to stimulate student interest." => "stimulation",
    "Please list any additional comments about the event/instructor and/or questions for your instructors." => "comments"
  }

  # from csv file
  def self.import_from_file(file)
    type = 0
    headers = []
    devs = []
    CSV.foreach(file.path) do |row|
      if $. == 1
        row.each do |col|
          if col[/Speaker/] == "Speaker"
            type = 1
          end
          headers << ExitTicketImporter::MAPPER[col]
        end
        headers << "type"
        next
      end
      devs << row
    end

    data = []
    devs.each do |dev|
      d = {}
      dev.each_with_index do |col, idx|
        next if headers[idx] == nil
        if headers[idx] == "submitted_at"
          p = col.split(' ')[0].split('/')
          year = p[2]
          day = p[1].length == 1 ? "0#{p[1]}" : p[1]
          month = p[0].length == 1 ? "0#{p[0]}" : p[0]
          date = "#{year}#{month}#{day}"
          d[headers[idx]] = Date.parse("#{year}#{month}#{day}").to_datetime
        elsif headers[idx] == "questions"
          d["questions"] = [] if d["questions"].nil?
          d["questions"] << {
            question: "question",
            answer: col
          }
        elsif headers[idx] == "type"
          d["type"] = type
        else
          d[headers[idx]] = col
        end
      end
      d["questions"] = JSON.generate(d["questions"])
      data << d
    end
    data.each do  |ticket_data|
      if developer = Developer.where("full_name = ?", ticket_data["name"].downcase).last
        ticket_data.delete("name")
        if t = ExitTicket.where("submitted_at = ? and developer_id = ? and type = ?", ticket_data["submitted_at"], developer.id, type).first
          t.update_attributes(ticket_data)
        else
          ticket = ExitTicket.new(ticket_data)
          developer.exit_tickets << ticket
        end
      end
    end
  end

  # from response sheet
  def import_from_form(form_data)
    json = JSON.parse(form_data["tickets"])
    tickets = json["tickets"]
    tickets.each do |ticket|
      if developer = Developer.where("full_name = ?", ticket["name"].downcase).first
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
  end

end
