class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|

      t.integer :application_id
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :phone
      t.string :email
      t.timestamp :birthday

      t.boolean :veteran
      t.integer :personal_device
      t.boolean :immigrant
      t.integer :education_status
      t.integer :current_annual_income
      t.boolean :free_or_reduced_lunch

      t.string :github_username
      t.integer :tshirt_size

      t.string :high_school
      t.integer :high_school_gpa_cents
      t.integer :sat_score

      t.boolean :first_generation_college_student
      t.string :college_or_university
      t.string :college_major
      t.integer :number_of_college_credits_cents
      t.integer :college_gpa_cents
      t.boolean :public_or_community_college

      t.string :masters_college
      t.string :masters_concentration
      t.integer :masters_gpa_cents

      t.string :degree_currently_pursuing
      t.string :current_school
      t.string :current_concentration
      t.integer :current_gpa_cents
      t.integer :current_employment_status
      t.string :current_employer
      t.string :current_job_title

      t.timestamps null: false
    end
  end
end
