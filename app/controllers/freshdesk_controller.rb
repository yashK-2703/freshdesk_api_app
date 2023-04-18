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
    end
    render json: conversations
  end
end
