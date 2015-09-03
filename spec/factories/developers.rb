FactoryGirl.define do
  factory :developer do
    first_name "text"
    last_name "example"
    email "textexample@gmail.com "
    full_name "text example"
  end
end

# == Schema Information
#
# Table name: developers
#
#  id                                :integer          not null, primary key
#  application_id                    :integer
#  first_name                        :string
#  last_name                         :string
#  age                               :integer
#  phone                             :string
#  email                             :string
#  date_of_birth                     :datetime
#  veteran                           :boolean
#  personal_device                   :integer          default(0)
#  immigrant                         :boolean
#  education_status                  :integer          default(0)
#  current_annual_income             :integer
#  free_or_reduced_lunch             :boolean
#  github_username                   :string
#  tshirt_size                       :integer          default(0)
#  high_school                       :string
#  high_school_gpa_cents             :integer
#  sat_score                         :integer
#  first_generation_college_student  :boolean
#  undergrad_college_or_university   :string
#  undergrad_major                   :string
#  number_of_undergrad_credits_cents :integer
#  undergrad_gpa_cents               :integer
#  public_or_community_college       :boolean
#  masters_college                   :string
#  masters_concentration             :string
#  masters_gpa_cents                 :integer
#  degree_currently_pursuing         :string
#  current_school                    :string
#  current_concentration             :string
#  current_gpa_cents                 :integer
#  current_employment_status         :integer          default(0)
#  current_employer                  :string
#  current_job_title                 :string
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  gender                            :integer
#  borrows_laptop                    :boolean
#  race_ethnicity                    :string
#  online_portfolio_url              :string
#  graduate_college_or_university    :string
#  graduate_concentration            :string
#  number_of_graduate_credits_cents  :integer
#  graduate_gpa_cents                :integer
#  is_current_student                :boolean
#  linkedin_url                      :string
#  coding_background                 :integer          default(0)
#  cohort_id                         :integer
#  full_name                         :string
#
