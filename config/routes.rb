Rails.application.routes.draw do
  get '/tickets', to: "freshdesk#fetch_tickets"
  get '/conversations', to: "freshdesk#fetch_conversations"
	get '/tickets/:id/conversations', to: "freshdesk#fetch_conversation_by_ticket"
end

