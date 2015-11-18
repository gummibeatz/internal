module Admin
  class EvaluationsController < Admin::AdminController
    def index
      @evaluations = Evaluation.all
      @table_titles = table_titles
    end

    private 
    def table_titles
      titles = []
      evaluations = Evaluation.all
      JSON.parse(evaluations.first.json_scores).each do |key,value|
        titles.push key
      end
    titles
    end

  end
end
