class AddQuestionsToExitTickets < ActiveRecord::Migration
  def change
    add_column :exit_tickets, :questions, :string, array: true, default: []
  end
end
