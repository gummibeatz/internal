class AddSubmittedAtToExitTickets < ActiveRecord::Migration
  def change
    add_column :exit_tickets, :submitted_at, :datetime
  end
end
