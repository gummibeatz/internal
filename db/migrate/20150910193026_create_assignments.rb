class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :max_score
      t.integer :type
      t.integer :unit_id
      t.string :github_url
      t.datetime :due_at
      t.boolean :active
      
      t.timestamps null: false
    end
  end
end
