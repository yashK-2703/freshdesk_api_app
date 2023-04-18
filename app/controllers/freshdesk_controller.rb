require 'net/http'
require 'json'
class FreshdeskController < ApplicationController
  FRESHDESK_DOMAIN = 'https://metricare-help.freshdesk.com'
  FRESHDESK_API_KEY = 'SNWq1fDOXLFrbfbrgcjk'
  FRESHDESK_PASSWORD = 'x'

  def fetch_tickets(render_response = true)
    uri = URI("#{FRESHDESK_DOMAIN}/api/v2/tickets")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(FRESHDESK_API_KEY, FRESHDESK_PASSWORD)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    tickets = JSON.parse(response.body)
    render json: tickets if render_response
    tickets.each do |ticket|
      puts ticket['id']
    end
    tickets
  end

  def fetch_conversations
    tickets = self.fetch_tickets(false)
    conversations = Array.new
    tickets.each do |ticket|
      ticket_id = ticket['id']
      ticket_conversation_uri = URI("#{FRESHDESK_DOMAIN}/api/v2/tickets/#{ticket_id}/conversations")
      request = Net::HTTP::Get.new(ticket_conversation_uri)
      request.basic_auth(FRESHDESK_API_KEY, FRESHDESK_PASSWORD)
      response = Net::HTTP.start(ticket_conversation_uri.hostname, ticket_conversation_uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      conversation = JSON.parse(response.body)
      conversations.push(conversation)
			conversation.each do |conversation|
				TicketConversation.create(
					ticket_id: conversation["ticket_id"],
					body_text: conversation["body_text"],
					incoming: conversation["incoming"],
					private: conversation["private"],
					user_id: conversation["user_id"],
					support_email: conversation["support_email"],
					source_id: conversation["source_id"],
					category_id: conversation["category_id"],
					from_email: conversation["from_email"],
					email_failure_count: conversation["email_failure_count"],
					outgoing_failures: conversation["outgoing_failures"],
					thread_id: conversation["thread_id"],
					thread_message_id: conversation["thread_message_id"],
					created_at: conversation["created_at"],
					updated_at: conversation["updated_at"],
					last_edited_at: conversation["last_edited_at"],
					last_edited_user_id: conversation["last_edited_user_id"],
					automation_id: conversation["automation_id"],
					automation_type_id: conversation["automation_type_id"],
					auto_response: conversation["auto_response"],
      		source_additional_info: conversation["source_additional_info"]
				)
			end
    end
    render json: conversations
  end
end
