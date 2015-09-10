class AddIndexToUnits < ActiveRecord::Migration
  def change
    add_column :units, :index, :integer
  end
end
