class AddTypeToExitTickets < ActiveRecord::Migration
  def change
    add_column :exit_tickets, :type, :integer, default: 0
  end
end
