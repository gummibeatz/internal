class AddOriginalFormUrlToExitTickets < ActiveRecord::Migration
  def change
    add_column :exit_tickets, :original_form_url, :string
  end
end
