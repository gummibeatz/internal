class RemoveUnitIdFromAssessment < ActiveRecord::Migration
  def change
    remove_column :assessments, :unit_id
  end
end
