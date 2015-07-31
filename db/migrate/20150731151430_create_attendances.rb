class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :status, default: 0
      t.integer :developer_id

      t.timestamps null: false
    end

    add_index :attendances, :status
    add_index :attendances, :developer_id
  end
end
