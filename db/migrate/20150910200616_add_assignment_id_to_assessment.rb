class AddAssignmentIdToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :assignment_id, :integer
    add_index :assessments, :assignment_id
  end
end
