class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer   :developer_id
      t.text      :json_scores
      t.text      :json_responses
      t.integer   :type
      t.string    :unit
      t.timestamps null: false
    end
    add_index :evaluations, :developer_id
  end
end
