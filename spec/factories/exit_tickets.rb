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
    submitted_at { Date.parse(Time.now.to_s).to_datetime }
    questions "[{\"question\":\"In which method can you pass data from one view controller to another?\"\"answer\":\"prepare for segue\"}]"
    score 1.0
    summary_form_url "https://docs.google.com/a/c4q.nyc/forms/d/1UC8AkYWjrz3dzuhFGTZt6vthL2Ap1s4c03CdM2nvAlk/viewanalytics"
    type "technical"
  end
end
