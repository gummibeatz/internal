class SummaryFormUrl < ActiveRecord::Migration
  def change
    add_column :exit_tickets, :summary_form_url, :string
  end
end
