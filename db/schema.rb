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

ActiveRecord::Schema.define(:version => 20111102122857) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.string   "name",       :default => "Anonymous", :null => false
    t.string   "email"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "manageable_content_page_contents", :force => true do |t|
    t.integer  "page_id"
    t.string   "key"
    t.boolean  "short",      :default => false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manageable_content_page_contents", ["page_id", "key"], :name => "index_manageable_content_page_contents_on_page_id_and_key", :unique => true

  create_table "manageable_content_pages", :force => true do |t|
    t.string   "key"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manageable_content_pages", ["key", "locale"], :name => "index_manageable_content_pages_on_key_and_locale", :unique => true

  create_table "partners", :force => true do |t|
    t.string   "name"
    t.string   "avatar"
    t.text     "biography"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_for_url"
  end

  create_table "posts", :force => true do |t|
    t.integer  "partner_id"
    t.datetime "published_at"
    t.text     "excerpt"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "category"
    t.string   "title_for_url"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "picture"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "excerpt"
    t.string   "title_for_url"
    t.string   "external_url"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
