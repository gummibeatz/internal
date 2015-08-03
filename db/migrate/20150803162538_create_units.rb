class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.datetime :started_at
      t.datetime :ended_at

      t.integer :cohort_id
      t.timestamps null: false
    end
    add_index :units, :cohort_id
  end
end
