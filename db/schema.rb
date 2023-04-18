# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_04_18_090244) do

  create_table "ticket_conversations", force: :cascade do |t|
    t.integer "ticket_id"
    t.string "body_text"
    t.boolean "incoming"
    t.boolean "private"
    t.integer "user_id"
    t.string "support_email"
    t.integer "source_id"
    t.integer "category_id"
    t.string "from_email"
    t.integer "email_failure_count"
    t.string "outgoing_failures"
    t.integer "thread_id"
    t.integer "thread_message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_edited_at"
    t.integer "last_edited_user_id"
    t.integer "automation_id"
    t.integer "automation_type_id"
    t.boolean "auto_response"
    t.string "source_additional_info"
  end

end
