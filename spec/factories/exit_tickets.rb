FactoryGirl.define do
  factory :exit_ticket do
    certainty 50
    quality 4
    difficulty 4
    communication 4
    stimulation 4
    pace_and_speed 4
    understanding 3
    recall 3
    comments "Hi mike"
    original_form_url "https://docs.google.com/forms/d/1UC8AkYWjrz3dzuhFGTZt6vthL2Ap1s4c03CdM2nvAlk/viewform"
    submitted_at { Date.today.to_datetime }
    questions "[{\"question\":\"In which method can you pass data from one view controller to another?\"\"answer\":\"prepare for segue\"}]"
    score 1.0
    summary_form_url "https://docs.google.com/a/c4q.nyc/forms/d/1UC8AkYWjrz3dzuhFGTZt6vthL2Ap1s4c03CdM2nvAlk/viewanalytics"
    type "technical"
  end
end

# == Schema Information
#
# Table name: exit_tickets
#
#  id                :integer          not null, primary key
#  certainty         :integer          default(0)
#  quality           :integer          default(0)
#  difficulty        :integer          default(0)
#  communication     :integer          default(0)
#  stimulation       :integer          default(0)
#  pace_and_speed    :integer          default(0)
#  understanding     :integer          default(0)
#  recall            :integer          default(0)
#  comments          :string
#  developer_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  original_form_url :string
#  submitted_at      :datetime
#  questions         :text
#  score             :float
#  summary_form_url  :string
#  type              :integer          default(0)
#
