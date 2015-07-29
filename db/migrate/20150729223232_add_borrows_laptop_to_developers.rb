class AddBorrowsLaptopToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :borrows_laptop, :boolean
    add_column :developers, :race_ethnicity, :string
    add_column :developers, :race_ethnicity, :string
    add_column :developers, :online_portfolio_url, :string
    add_column :developers, :graduate_college_or_university, :string
    add_column :developers, :graduate_concentration, :string
    add_column :developers, :number_of_graduate_credits_cents, :integer
    add_column :developers, :graduate_gpa_cents, :integer
    add_column :developers, :is_current_student, :boolean
    add_column :developers, :coding_background, :integer, default: 0
    rename_column :developers, :college_major, :undergrad_major
    rename_column :developers, :number_of_college_credits_cents, :number_of_undergrad_credits_cents
    rename_column :developers, :college_gpa_cents, :undergrad_gpa_cents
    rename_column :developers, :college_or_university, :undergrad_college_or_university
  end
end
