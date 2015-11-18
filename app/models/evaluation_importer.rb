module EvaluationImporter
  require 'csv'
  def EvaluationImporter.import_EOU(file)
    CSV.open(file, 'r') do |csv|
      header = csv.first
      scoreRange, responseRange = self.scoreRange(header)
      puts scoreRange
      puts responseRange
      puts header 
      csv.each do |row|
        next if $. == 0
        submitted_at = row[0]
        first_name = row[1].downcase.strip
        last_name = row[2].downcase.strip
        full_name = first_name + " " + last_name
        dev = Developer.where(full_name: full_name).first
        puts dev.id
        evaluation = Evaluation.new(developer_id: dev.id, type: "EOU")
        scores = Hash.new
        responses = Hash.new
        scoreRange.each do |i|
          scores[header[i].to_s] = row[i].to_s
        end
        responseRange.each do |i|
          responses[header[i].to_s] = row[i].to_s 
        end
        evaluation.json_scores = scores.to_json 
        evaluation.json_responses = responses.to_json 
        evaluation.save!
      end
    end
  end

  def EvaluationImporter.scoreRange(header)
    scoreRangeStart = 0  
    scoreRangeEnd = 0
    responseRangeEnd = header.count
    scoreRangeStart = header.index{ |cell| cell.include? "Please rate" }
    scoreRangeEnd = scoreRangeStart
    header.drop(scoreRangeStart)
    header.each do |cell|
      scoreRangeEnd += 1 if cell.include? "Please rate "
    end
    return Range.new(scoreRangeStart, scoreRangeEnd-1), Range.new(scoreRangeEnd, responseRangeEnd)
  end

end
