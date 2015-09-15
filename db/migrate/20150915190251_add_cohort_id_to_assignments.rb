class AddCohortIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :cohort_id, :integer
    add_index :assignments, :cohort_id
  end
end
