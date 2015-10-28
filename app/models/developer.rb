class Developer < ActiveRecord::Base


  enum education_status: [:not_applicable, :some_high_school, :high_school_graduate, :some_college, :pursuing_associates, :associates, :pursuing_bachelors, :bachelors, :pursuing_masters, :masters]
  enum tshirt_size: [:extra_small, :small, :medium, :large, :extra_large]
  enum personal_device: [:iphone, :android, :windows]
  enum current_employment_status: [:student, :retired, :not_employed_not_looking, :not_employed_looking, :self_employed, :part_time, :full_time]
  enum coding_background: [:no_experience, :limited_experience, :some_experience, :workshop_level_experience, :college_level_experience]
  enum gender: [:female, :male]

  has_many :addresses, foreign_key: :user_id
  has_many :exit_tickets, -> {order(submitted_at: :desc)}
  has_many :attendances
  has_many :assessments
  has_many :equipments
  has_many :votes, dependent: :destroy
  has_many :clicker_answers, through: :votes

  belongs_to :cohort

  validates :email, presence: true, uniqueness: true
  validates :github_username, presence: true, uniqueness: true
  validates :full_name, presence: true

  has_one :user

  def display_name
    full_name.split(" ").map(&:capitalize).join(" ")
  end

  # figure out how to scope this
  def current_assignments
    assessments.include(:assignments).where('assignments.active = ?', 'true').references(:assignments)
  end

  def has_user?
    !self.user.nil?
  end

  def belongs_to_cohort?
    !self.cohort.nil?
  end

  def not_meeting_requirements?
    attendances = self.attendances.in_range(self.cohort.current_unit.range)
    return attendances.absent_unexcused.count > MAX_ABSENT_DAYS || attendances.late_unexcused.count > MAX_LATE_DAYS 
  end

  def in_danger_of_not_meeting_requirements?
    attendances = self.attendances.in_range(self.cohort.current_unit.range)
    return attendances.absent_unexcused.count == MAX_ABSENT_DAYS || attendances.late_unexcused.count == MAX_LATE_DAYS
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
#  linkedin_url                      :string
#  online_portfolio_url              :string
#  graduate_college_or_university    :string
#  graduate_concentration            :string
#  number_of_graduate_credits_cents  :integer
#  graduate_gpa_cents                :integer
#  is_current_student                :boolean
#  coding_background                 :integer          default(0)
#  cohort_id                         :integer
#  full_name                         :string
#
