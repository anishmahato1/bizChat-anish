# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_17_042252) do
  create_table "channels", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_channels_on_admin_id"
  end

  create_table "channels_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "channel_id", null: false
    t.index ["channel_id"], name: "index_channels_users_on_channel_id"
    t.index ["user_id"], name: "index_channels_users_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", limit: 500
    t.string "receiver_type"
    t.integer "receiver_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_type", "receiver_id"], name: "index_messages_on_receiver"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "gender", null: false
    t.boolean "is_admin", default: false, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "channels", "admins"
  add_foreign_key "messages", "users", column: "sender_id"
end
