class AddTimestampToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :timestamp, :datetime
  end
end
