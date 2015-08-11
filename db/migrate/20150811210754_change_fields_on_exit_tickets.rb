class ChangeFieldsOnExitTickets < ActiveRecord::Migration
  def change
    rename_column :exit_tickets, :overall_quality, :quality
    rename_column :exit_tickets, :instructors_ability_to_communicate, :communication
    rename_column :exit_tickets, :instructors_ability_to_stimulate, :stimulation
    rename_column :exit_tickets, :recall_information_from_previous_class, :recall
    rename_column :exit_tickets, :additional_comments, :comments
  end
end
