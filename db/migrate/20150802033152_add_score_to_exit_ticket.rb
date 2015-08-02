class AddScoreToExitTicket < ActiveRecord::Migration
  def change
    add_column :exit_tickets, :score, :float
  end
end
