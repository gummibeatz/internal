class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :version
      t.string :name

      t.timestamps null: false
    end

    Cohort.create(name: "Access Code", version: "2.2")
  end
end
