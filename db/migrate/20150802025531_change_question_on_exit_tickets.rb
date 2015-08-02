class ChangeQuestionOnExitTickets < ActiveRecord::Migration
  def change
    remove_column :exit_tickets, :questions
    add_column :exit_tickets, :questions, :text
  end
end
