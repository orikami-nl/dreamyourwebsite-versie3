# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121129224557) do

  create_table "admins", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "associates", :force => true do |t|
    t.string    "name"
    t.string    "avatar"
    t.text      "biography"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name_for_url"
    t.boolean   "active",       :default => true
  end

  create_table "comments", :force => true do |t|
    t.text      "body"
    t.string    "name",       :default => "Anonymous", :null => false
    t.string    "email"
    t.integer   "post_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "dashboard_bank_balances", :force => true do |t|
    t.integer   "bank_id"
    t.timestamp "datetime"
    t.decimal   "value"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "dashboard_banks", :force => true do |t|
    t.string    "name"
    t.timestamp "last_update"
    t.decimal   "current_balance"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
  end

  create_table "dashboard_billable_hours", :force => true do |t|
    t.timestamp "datetime"
    t.float     "value"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "dashboard_incoming_invoices", :force => true do |t|
    t.string    "currency"
    t.integer   "invoice_id"
    t.decimal   "total_paid"
    t.decimal   "total_unpaid"
    t.string    "state"
    t.date      "date"
    t.timestamp "created_at",   :null => false
    t.timestamp "updated_at",   :null => false
  end

  create_table "dashboard_invoices", :force => true do |t|
    t.string    "currency"
    t.decimal   "total_paid"
    t.decimal   "total_price_excl_tax"
    t.decimal   "total_price_incl_tax"
    t.decimal   "total_unpaid"
    t.string    "state"
    t.timestamp "created_at",           :null => false
    t.timestamp "updated_at",           :null => false
  end

  create_table "dashboard_transactions", :force => true do |t|
    t.date      "date"
    t.string    "name"
    t.integer   "account"
    t.integer   "contra_account"
    t.string    "code"
    t.decimal   "amount"
    t.string    "transfer_type"
    t.text      "description"
    t.timestamp "created_at",     :null => false
    t.timestamp "updated_at",     :null => false
    t.integer   "bank_id"
  end

  create_table "manageable_content_page_contents", :force => true do |t|
    t.integer   "page_id"
    t.string    "key"
    t.boolean   "short",      :default => false
    t.text      "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "manageable_content_page_contents", ["page_id", "key"], :name => "index_manageable_content_page_contents_on_page_id_and_key", :unique => true

  create_table "manageable_content_pages", :force => true do |t|
    t.string    "key"
    t.string    "locale"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "manageable_content_pages", ["key", "locale"], :name => "index_manageable_content_pages_on_key_and_locale", :unique => true

  create_table "mercury_images", :force => true do |t|
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.timestamp "created_at",         :null => false
    t.timestamp "updated_at",         :null => false
  end

  create_table "page_contents", :force => true do |t|
    t.integer   "page_id"
    t.string    "key"
    t.boolean   "short"
    t.text      "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string    "key"
    t.string    "locale"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "partners", :force => true do |t|
    t.string    "name"
    t.string    "logo"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.string    "website"
  end

  create_table "posts", :force => true do |t|
    t.integer   "associate_id"
    t.timestamp "published_at"
    t.text      "excerpt"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "title"
    t.string    "category"
    t.string    "title_for_url"
    t.boolean   "draft"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "picture"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "excerpt"
    t.string   "title_for_url"
    t.string   "external_url"
    t.string   "full_picture"
    t.text     "body"
    t.string   "project_type"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "taggings", :force => true do |t|
    t.integer   "tag_id"
    t.integer   "taggable_id"
    t.string    "taggable_type"
    t.integer   "tagger_id"
    t.string    "tagger_type"
    t.string    "context"
    t.timestamp "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
