class AddCohortIdToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :cohort_id, :integer
  end
end
