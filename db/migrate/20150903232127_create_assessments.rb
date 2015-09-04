class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|

      t.timestamps null: false
    end
  end
end
