class AddDeveloperIdToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :developer_id, :integer
    add_index :equipment, :developer_id
  end
end
