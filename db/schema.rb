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

ActiveRecord::Schema.define(:version => 20121113165933) do

  create_table "albums", :force => true do |t|
    t.string   "name"
    t.string   "cover_url"
    t.integer  "band_id"
    t.integer  "user_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "coverart_file_name"
    t.string   "coverart_content_type"
    t.integer  "coverart_file_size"
    t.datetime "coverart_updated_at"
  end

  create_table "bands", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "members"
    t.boolean  "individual_artist"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "earned"
    t.integer  "earned_company"
    t.integer  "songs_sold",        :default => 0
  end

  create_table "credits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "user_id"
    t.integer  "song_id"
    t.integer  "value"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "band_profit"
    t.integer  "company_profit"
  end

  create_table "songs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "band_id"
    t.integer  "cost"
    t.string   "download_url"
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "sales"
    t.integer  "album_id"
    t.string   "mp3_file_name"
    t.string   "mp3_content_type"
    t.integer  "mp3_file_size"
    t.datetime "mp3_updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "band_id"
    t.integer  "total_purchased"
    t.datetime "expires"
    t.datetime "last_purchase"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "subscriptions", ["band_id"], :name => "index_subscriptions_on_band_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "credit_id"
    t.boolean  "successful"
    t.string   "ip_during_purchase"
    t.integer  "credits_value"
    t.datetime "purchase_date"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "transaction_type"
    t.string   "paypal_transaction_id"
  end

  add_index "transactions", ["credit_id"], :name => "index_transactions_on_credit_id"

  create_table "users", :force => true do |t|
    t.string   "email",                   :default => "",     :null => false
    t.string   "encrypted_password",      :default => "",     :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "role",                    :default => "user"
    t.boolean  "admin",                   :default => false
    t.integer  "total_credits_purchased"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
