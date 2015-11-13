class AddDefaultValueToEquipmentType < ActiveRecord::Migration
  def change
    change_column :equipment, :type, :integer, default: 0
  end
end
