class AddToEmailsToTicketConversation < ActiveRecord::Migration[7.0]
  def change
    add_column :ticket_conversations, :to_emails, :json
		add_column :ticket_conversations, :cc_emails, :json
		add_column :ticket_conversations, :bcc_emails, :json
		add_column :ticket_conversations, :attachments, :json
  end
end
