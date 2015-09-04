class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.float :max_score
      t.float :score
      t.integer :developer_id
      t.string :github_url
      t.datetime :due_at
      t.integer :unit_id

      t.timestamps null: false
    end

    add_index :assessments, :developer_id
    add_index :assessments, :unit_id
  end
end
