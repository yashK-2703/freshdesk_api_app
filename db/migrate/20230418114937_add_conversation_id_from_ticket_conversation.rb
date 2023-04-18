class AddConversationIdFromTicketConversation < ActiveRecord::Migration[7.0]
  def change
  	add_column :ticket_conversations, :conversation_id, :integer
	end
end
