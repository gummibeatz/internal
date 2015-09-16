require 'rails_helper'

RSpec.describe Developer, type: :model do

  # associations
  it { should have_many(:exit_tickets) }
  it { should have_many(:attendances) }
  it { should have_many(:assessments) }
  it { should have_many(:addresses) }
  it { should belong_to(:cohort) }
  it { should have_one(:user) }

  # validations
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:github_username) }
  it { should validate_uniqueness_of(:github_username) }

  # enum scopes
  it { should define_enum_for(:education_status) }
  it { should define_enum_for(:tshirt_size) }
  it { should define_enum_for(:personal_device) }
  it { should define_enum_for(:current_employment_status) }
  it { should define_enum_for(:coding_background) }
  it { should define_enum_for(:gender) }

  it "creates a developer" do
    expect {
      create(:developer)
    }.to change(Developer, :count).by(1)
  end

  it "have no user by default" do
    developer = create(:developer)
    expect(developer.user).to be_nil
  end

  it "should format display name" do
    developer = build(:developer)
    expect(developer.display_name == "Test Developer").to be_truthy
 end

  fit "should send email when not meeting reqs" do
    now = Date.today
    developer = create(:developer)
    developer.create_user!(
      email: developer.email,
      password: Devise.friendly_token
    )
    developer.attendances.create!(status: "late_unexcused_5_minutes", timestamp: now-2)
    developer.attendances.create!(status: "late_unexcused_10_minutes", timestamp: now-1)
    
    expect{
      developer.attendances.create!(status: "late_unexcused_10_minutes", timestamp: now-3)
    }.to change(Notification, :count).by(1)
  end

  fit "should send email when in danger of not meeting reqs" do
    now = Date.today
    developer = create(:developer)
    developer.create_user!(
      email: developer.email,
      password: Devise.friendly_token
    )
    expect{
      developer.attendances.create(status: "late_unexcused_5_minutes", timestamp: now-2)
      developer.attendances.create(status: "late_unexcused_10_minutes", timestamp: now-1)
    }.to change(Notification, :count).by(1)
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
