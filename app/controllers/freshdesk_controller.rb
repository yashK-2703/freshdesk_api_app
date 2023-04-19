require 'net/http'
require 'json'
class FreshdeskController < ApplicationController
  FRESHDESK_DOMAIN = 'https://metricare-help.freshdesk.com'
  FRESHDESK_API_KEY = 'SNWq1fDOXLFrbfbrgcjk'
  FRESHDESK_PASSWORD = 'x'

  def fetch_tickets(render_response = true)
    uri = URI("#{FRESHDESK_DOMAIN}/api/v2/tickets?include=stats")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(FRESHDESK_API_KEY, FRESHDESK_PASSWORD)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    tickets = JSON.parse(response.body)
		puts "tickets are",tickets;
    render json: tickets if render_response
    tickets.each do |ticket|
      tickets.each do |ticket|
        existing_ticket = Ticket.find_by(ticket_id: ticket['id'])

        if existing_ticket
          existing_ticket.update!(
            cc_emails: ticket['cc_emails'],
            fwd_emails: ticket['fwd_emails'],
            reply_cc_emails: ticket['reply_cc_emails'],
            ticket_cc_emails: ticket['ticket_cc_emails'],
            fr_escalated: ticket['fr_escalated'],
            spam: ticket['spam'],
            email_config_id: ticket['email_config_id'],
            group_id: ticket['group_id'],
            priority: ticket['priority'],
            requester_id: ticket['requester_id'],
            responder_id: ticket['responder_id'],
            source: ticket['source'],
            company_id: ticket['company_id'],
            status: ticket['status'],
            subject: ticket['subject'],
            association_type: ticket['association_type'],
            support_email: ticket['support_email'],
            to_emails: ticket['to_emails'],
            product_id: ticket['product_id'],
            type: ticket['type'],
            due_by: ticket['due_by'],
            fr_due_by: ticket['fr_due_by'],
            is_escalated: ticket['is_escalated'],
            custom_fields: ticket['custom_fields'],
            created_at: ticket['created_at'],
						updated_at: ticket['updated_at'],
						associated_tickets_count: ticket['associated_tickets_count'],
						tags: ticket['tags'],
						nr_due_by: ticket['nr_due_by'],
						agent_responded_at: ticket['stats']['agent_responded_at'],
						requester_responded_at: ticket['stats']['requester_responded_at'],
						first_responded_at: ticket['stats']['first_responded_at'],
						status_updated_at: ticket['stats']['status_updated_at'],
						reopened_at: ticket['stats']['reopened_at'],
						resolved_at: ticket['stats']['resolved_at'],
						closed_at: ticket['stats']['closed_at'],
						pending_since: ticket['stats']['pending_since']
					)
				else
					Ticket.create!(
            cc_emails: ticket['cc_emails'],
            fwd_emails: ticket['fwd_emails'],
            reply_cc_emails: ticket['reply_cc_emails'],
            ticket_cc_emails: ticket['ticket_cc_emails'],
            fr_escalated: ticket['fr_escalated'],
            spam: ticket['spam'],
            email_config_id: ticket['email_config_id'],
            group_id: ticket['group_id'],
            priority: ticket['priority'],
            requester_id: ticket['requester_id'],
            responder_id: ticket['responder_id'],
            source: ticket['source'],
            company_id: ticket['company_id'],
            status: ticket['status'],
            subject: ticket['subject'],
            association_type: ticket['association_type'],
            support_email: ticket['support_email'],
            to_emails: ticket['to_emails'],
            product_id: ticket['product_id'],
            ticket_id: ticket['id'],
            type: ticket['type'],
            due_by: ticket['due_by'],
            fr_due_by: ticket['fr_due_by'],
            is_escalated: ticket['is_escalated'],
            custom_fields: ticket['custom_fields'],
            created_at: ticket['created_at'],
            updated_at: ticket['updated_at'],
            associated_tickets_count: ticket['associated_tickets_count'],
						tags: ticket['tags'],
						nr_due_by: ticket['nr_due_by'],
						agent_responded_at: ticket['stats']['agent_responded_at'],
						requester_responded_at: ticket['stats']['requester_responded_at'],
						first_responded_at: ticket['stats']['first_responded_at'],
						status_updated_at: ticket['stats']['status_updated_at'],
						reopened_at: ticket['stats']['reopened_at'],
						resolved_at: ticket['stats']['resolved_at'],
						closed_at: ticket['stats']['closed_at'],
						pending_since: ticket['stats']['pending_since']
					)
				end
			end
		end
		tickets
	end

	def fetch_ticket_by_id
		ticket_id = params[:id]
		ticket_conversation_uri = URI("#{FRESHDESK_DOMAIN}/api/v2/tickets/#{ticket_id}")
		request = Net::HTTP::Get.new(ticket_conversation_uri)
		request.basic_auth(FRESHDESK_API_KEY, FRESHDESK_PASSWORD)
		response = Net::HTTP.start(ticket_conversation_uri.hostname, ticket_conversation_uri.port, use_ssl: true) do |http|
			http.request(request)
		end
		ticket = JSON.parse(response.body)
		render json: ticket
	end

	def fetch_conversation_by_ticket
		ticket_id = params[:id]
		ticket_conversation_uri = URI("#{FRESHDESK_DOMAIN}/api/v2/tickets/#{ticket_id}/conversations")
		request = Net::HTTP::Get.new(ticket_conversation_uri)
		request.basic_auth(FRESHDESK_API_KEY, FRESHDESK_PASSWORD)
		response = Net::HTTP.start(ticket_conversation_uri.hostname, ticket_conversation_uri.port, use_ssl: true) do |http|
			http.request(request)
		end
		conversation = JSON.parse(response.body)
			render json: conversation
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
					conversation_id: conversation["id"],
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
      		source_additional_info: conversation["source_additional_info"],
					to_emails: conversation["to_emails"],
					cc_emails: conversation["cc_emails"],
					bcc_emails: conversation["bcc_emails"],
					attachments: conversation["attachments"]
				)
			end
    end
    render json: conversations
  end

	def average_time
		tickets = Ticket.where.not(first_responded_at: nil)
		response_times = tickets.map { |ticket| ticket.first_responded_at - ticket.created_at }
		@avg_response_time = response_times.sum / response_times.size.to_f
		@avg_response_time = "%02d:%02d:%02d" % [@avg_response_time / 3600, @avg_response_time / 60 % 60, @avg_response_time % 60]
		tickets = Ticket.where(status: [4, 5]).where.not(resolved_at: nil)
		resolution_times = tickets.map { |ticket| ticket.resolved_at - ticket.created_at }
		@avg_resolution_time = resolution_times.sum / resolution_times.size.to_f
		@avg_resolution_time = "%02d:%02d:%02d" % [@avg_resolution_time / 3600, @avg_resolution_time / 60 % 60, @avg_resolution_time % 60]
		render json: { avg_response_time: @avg_response_time, avg_resolution_time: @avg_resolution_time }
	end

end
