module ClickerQuestionsHelper
  def visualize_votes_for(answer)
    content_tag :div, class: 'progress' do
      content_tag :div, class: 'progress-bar',
                  style: "width: #{answer.clicker_question.normalized_votes_for(answer)*100}%" do
        "#{answer.votes.count}"
      end
    end
  end
end
