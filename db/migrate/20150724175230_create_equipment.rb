class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :type
      t.string :description
      t.string :reference_id

      t.timestamps null: false
    end

    add_index :equipment, :reference_id
  end
end
