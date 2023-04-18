class Createtickettable < ActiveRecord::Migration[5.2]
	def change
		create_table :tickets do |t|
			t.json :cc_emails, default: []
			t.json :fwd_emails, default: []
			t.json :reply_cc_emails, default: []
			t.json :ticket_cc_emails, default: []
			t.boolean :fr_escalated, default: false
			t.boolean :spam, default: false
			t.integer :email_config_id
			t.integer :group_id
			t.integer :priority
			t.integer :requester_id
			t.integer :responder_id
			t.integer :source
			t.integer :company_id
			t.integer :status
			t.string :subject
			t.string :association_type
			t.string :support_email
			t.json :to_emails, default: []
			t.integer :product_id
			t.string :type
			t.datetime :due_by
			t.datetime :fr_due_by
			t.boolean :is_escalated, default: false
			t.json :custom_fields
			t.integer :ticket_id
			t.integer :associated_tickets_count
			t.json :tags
			t.datetime :nr_due_by
			t.boolean :nr_escalated
		end
	end
end
