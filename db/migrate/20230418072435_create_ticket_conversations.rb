class CreateTicketConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :ticket_conversations do |t|
      t.integer :conversation_id
      t.integer :ticket_id
      t.string :body_text
      t.boolean :incoming
      t.boolean :private
      t.integer :user_id
      t.string :support_email
      t.integer :source_id
      t.integer :category_id
      t.string :from_email
      t.integer :email_failure_count
      t.string :outgoing_failures
      t.integer :thread_id
      t.integer :thread_message_id
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :last_edited_at
      t.integer :last_edited_user_id
      t.integer :automation_id
      t.integer :automation_type_id
      t.boolean :auto_response
      t.string :source_additional_info

      t.timestamps
    end
  end
end
