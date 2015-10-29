class ClickerQuestionsController < ApplicationController

  layout "clicker_questions"
  
  def index
    @clicker_questions = ClickerQuestion.all
  end

  def show
    @clicker_question = ClickerQuestion.includes(:clicker_answers).find_by_id(params[:id])
  end

  def new
    @clicker_question = ClickerQuestion.new
  end

  def edit
    @clicker_question = ClickerQuestion.find_by_id(params[:id])
  end

  def update
    @clicker_question = ClickerQuestion.find_by_id(params[:id])
    if @clicker_question.update_attributes(clicker_question_params)
      flash[:success] = "clicker question was updated!"
      redirect_to clicker_questions_path
    else
      render 'edit'
    end
  end

  def create
    @clicker_question = ClickerQuestion.new(clicker_question_params)
    if @clicker_question.save
      flash[:success] = 'Poll was created!'
      redirect_to clicker_questions_path
    else
      render 'new'
    end
  end

  def destroy 
    @clicker_question = ClickerQuestion.find_by_id(params[:id])
    if @clicker_question.destroy
      flash[:success] = "question was destroyed"
    else
      flash[:warning] = 'there was an error destroying the question'
    end
    redirect_to clicker_questions_path
  end

  private

  def clicker_question_params
    params.require(:clicker_question).permit(:question, clicker_answers_attributes: [:id, :answer, :_destroy])
  end

  def getChannelFeedWithDate(date)
    token = Rails.application.secrets.slack_access_code_2_2_token
    channel_id = "C0DBVPWHF"
    uri = URI("https://slack.com/api/channels.history?token=#{token}&&channel=#{channel_id}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    request.initialize_http_header(headers)
    response = http.request(request)
    response.body
  end
  
end
