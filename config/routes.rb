Rails.application.routes.draw do
  get '/tickets', to: "freshdesk#fetch_tickets"
  get '/conversations', to: "freshdesk#fetch_conversations"
end

