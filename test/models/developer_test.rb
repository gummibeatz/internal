require 'test_helper'

class DeveloperTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: developers
#
#  id                               :integer          not null, primary key
#  application_id                   :integer
#  first_name                       :string
#  last_name                        :string
#  age                              :integer
#  phone                            :string
#  email                            :string
#  date_of_birth                    :datetime
#  veteran                          :boolean
#  personal_device                  :integer          default(0)
#  immigrant                        :boolean
#  education_status                 :integer          default(0)
#  current_annual_income            :integer
#  free_or_reduced_lunch            :boolean
#  github_username                  :string
#  tshirt_size                      :integer          default(0)
#  high_school                      :string
#  high_school_gpa_cents            :integer
#  sat_score                        :integer
#  first_generation_college_student :boolean
#  college_or_university            :string
#  college_major                    :string
#  number_of_college_credits_cents  :integer
#  college_gpa_cents                :integer
#  public_or_community_college      :boolean
#  masters_college                  :string
#  masters_concentration            :string
#  masters_gpa_cents                :integer
#  degree_currently_pursuing        :string
#  current_school                   :string
#  current_concentration            :string
#  current_gpa_cents                :integer
#  current_employment_status        :integer          default(0)
#  current_employer                 :string
#  current_job_title                :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#
