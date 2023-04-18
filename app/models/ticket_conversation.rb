class TicketConversation < ApplicationRecord
	def self.create(ticket_id: , body_text: , incoming: , private: , user_id: , support_email: , source_id: , category_id: , from_email: , email_failure_count: , outgoing_failures: , thread_id: , thread_message_id: , created_at: , updated_at: , last_edited_at: , last_edited_user_id: , automation_id: , automation_type_id: , auto_response: , source_additional_info: )
		present = TicketConversation.exists?(
			ticket_id: ticket_id.to_i,
      body_text: body_text,
      incoming: incoming.to_s,
      private: private.to_s,
      user_id: user_id.to_i,
      support_email: support_email,
      source_id: source_id.to_i,
      category_id: category_id.to_i,
      from_email: from_email,
      email_failure_count: email_failure_count.to_i,
      outgoing_failures: outgoing_failures,
      thread_id: thread_id.to_i,
      thread_message_id: thread_message_id.to_i,
      created_at: created_at,
      updated_at: updated_at,
      last_edited_at: last_edited_at,
      last_edited_user_id: last_edited_user_id.to_i,
      automation_id: automation_id.to_i,
      automation_type_id: automation_type_id.to_i,
      auto_response: auto_response.to_s,
      source_additional_info: source_additional_info
    )
		ticket_conversation = TicketConversation.new(
			ticket_id: ticket_id.to_i,
			body_text: body_text,
			incoming: incoming.to_s,
			private: private.to_s,
			user_id: user_id.to_i,
			support_email: support_email,
			source_id: source_id.to_i,
			category_id: category_id.to_i,
			from_email: from_email,
			email_failure_count: email_failure_count.to_i,
			outgoing_failures: outgoing_failures,
			thread_id: thread_id.to_i,
			thread_message_id: thread_message_id.to_i,
			created_at: created_at,
			updated_at: updated_at,
			last_edited_at: last_edited_at,
			last_edited_user_id: last_edited_user_id.to_i,
			automation_id: automation_id.to_i,
			automation_type_id: automation_type_id.to_i,
			auto_response: auto_response.to_s,
			source_additional_info: source_additional_info
		)
		ticket_conversation.save! if !present
	end
end
