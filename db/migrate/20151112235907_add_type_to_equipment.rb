class AddTypeToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :type, :integer
  end
end
