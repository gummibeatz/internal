class VotesController < ApplicationController

  def create
    if params[:clicker_question] && params[:clicker_question][:id] && params[:clicker_answer] && params[:clicker_answer][:id]
      @clicker_question = ClickerQuestion.find_by_id(params[:clicker_question][:id])
      @answer = @clicker_question.clicker_answers.find_by_id(params[:clicker_answer][:id])
      if @answer && @clicker_question 
        @answer.votes.create()
        render js: 'alert(\'thanks! vote was saved!\');'
      else
        render js: 'alert(\'Your vote cannot be saved. Have you already voted?\');'
      end
    else
      render js: 'alert(\'Your vote cannot be saved.\');'
    end
  end
end