class AddTicketStatsToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :agent_responded_at, :datetime
    add_column :tickets, :requester_responded_at, :datetime
    add_column :tickets, :first_responded_at, :datetime
    add_column :tickets, :status_updated_at, :datetime
    add_column :tickets, :reopened_at, :datetime
    add_column :tickets, :resolved_at, :datetime
    add_column :tickets, :closed_at, :datetime
    add_column :tickets, :pending_since, :datetime
  end
end
