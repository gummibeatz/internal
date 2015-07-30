class CreateExitTickets < ActiveRecord::Migration
  def change
    create_table :exit_tickets do |t|
      t.integer :certainty, default: 0
      t.integer :overall_quality, default: 0
      t.integer :difficulty, default: 0
      t.integer :instructors_ability_to_communicate, default: 0
      t.integer :instructors_ability_to_stimulate, default: 0
      t.integer :pace_and_speed, default: 0
      t.integer :understanding, default: 0
      t.integer :recall_information_from_previous_class, default: 0
      t.string :additional_comments
      t.integer :developer_id

      t.timestamps null: false
    end
  end
end
