class ChangeFieldsOnUnit < ActiveRecord::Migration
  def change
    rename_column :units, :started_at, :start_at
    rename_column :units, :ended_at, :end_at
  end
end
