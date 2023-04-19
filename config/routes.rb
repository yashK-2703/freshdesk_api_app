Rails.application.routes.draw do
	get '/tickets', to: "freshdesk#fetch_tickets"
	get '/conversations', to: "freshdesk#fetch_conversations"
	get '/tickets/average_time', to: 'freshdesk#average_time'
	get '/tickets/:id', to: "freshdesk#fetch_ticket_by_id"
	get '/tickets/:id/conversations', to: "freshdesk#fetch_conversation_by_ticket"
end

