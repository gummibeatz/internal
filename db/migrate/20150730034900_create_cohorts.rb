class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :version
      t.string :name

      t.timestamps null: false
    end
  end
end
