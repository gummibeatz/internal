class AddCommentsToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :comments, :text
  end
end
