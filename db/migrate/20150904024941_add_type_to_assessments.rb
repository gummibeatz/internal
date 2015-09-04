class AddTypeToAssessments < ActiveRecord::Migration
  def change
    add_column :assessments, :type, :integer
  end
end
