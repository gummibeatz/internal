class ExitTicketImporter
  require 'csv'

  MAPPER = {
    "Timestamp" => "submitted_at",
    "Certainty (1-100)" => "certainty",
    "Name" => "name",
    "Please rate the overall quality of the class." => "overall_quality",
    "Please rate the difficulty of the class." => "difficulty",
    "Instructor's ability to communicate the subject matter." => "instructors_ability_to_communicate",
    "Instructor's ability to stimulate student interest." => "instructors_ability_to_stimulate",
    "Please rate the pace & speed of the class." => "pace_and_speed",
    "Please rate your understanding of the concepts covered in class." => "understanding",
    "How well do you recall the information taught in the last class?" => "recall_information_from_previous_class",
    "Please list any additional comments about the class/instructor and/or questions for your instructors." => "additional_comments"
  }

  def self.import(file)
    headers = []
    devs = []
    CSV.foreach(file.path) do |row|
      if $. == 1
        row.each { |col| headers << ExitTicketImporter::MAPPER[col] }
        next
      end
      devs << row
    end

    data = []
    devs.each do |dev|
      d = {}
      dev.each_with_index do |col, idx|
        if headers[idx]
          if headers[idx] == "submitted_at"
            p = col.split(' ')[0].split('/')
            year = p[2]
            day = p[1].length == 1 ? "0#{p[1]}" : p[1]
            month = p[0].length == 1 ? "0#{p[0]}" : p[0]
            date = "#{year}#{month}#{day}"
            d[headers[idx]] = Date.parse("#{year}#{month}#{day}").to_datetime
          else
            d[headers[idx]] = col
          end
        end
      end
      data << d
    end
    data.each do  |ticket_data|
      if developer = Developer.where("full_name = ?", ticket_data["name"]).last
        ticket_data.delete("name")
        if t = ExitTicket.where("submitted_at = ? AND developer_id = ?", ticket_data["submitted_at"], developer.id).first
          t.update_attributes(ticket_data)
        else
          ticket = ExitTicket.new(ticket_data)
          developer.exit_tickets << ticket
        end
      end
    end
  end

end
