class RemoveConversationIdFromTicketConversation < ActiveRecord::Migration[5.2]
  def change
    remove_column :ticket_conversations, :conversation_id, :integer
  end
end
