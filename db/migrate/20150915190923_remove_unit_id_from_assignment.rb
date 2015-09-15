class RemoveUnitIdFromAssignment < ActiveRecord::Migration
  def change
    remove_column :assignments, :unit_id
  end
end
