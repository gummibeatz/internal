class AddCohortIdToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :cohort_id, :integer
    Developer.all.each do |dev|
      dev.update_attribute(:cohort_id, 1)
    end
  end
end
