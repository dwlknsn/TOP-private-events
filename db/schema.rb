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

ActiveRecord::Schema[8.0].define(version: 2024_11_17_044325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "events", force: :cascade do |t|
    t.text "location", null: false
    t.bigint "host_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.datetime "datetime", null: false
    t.index ["host_id"], name: "index_events_on_host_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.datetime "requested_at", default: "2024-11-17 05:01:20", null: false
    t.datetime "accepted_at"
    t.datetime "declined_at"
    t.datetime "expires_at", null: false
    t.bigint "event_id", null: false
    t.bigint "invitee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_invitations_on_event_id"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
  end

  create_table "sign_ups", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "attendee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id"], name: "index_sign_ups_on_attendee_id"
    t.index ["event_id"], name: "index_sign_ups_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "users", column: "host_id"
  add_foreign_key "invitations", "events"
  add_foreign_key "invitations", "users", column: "invitee_id"
  add_foreign_key "sign_ups", "events"
  add_foreign_key "sign_ups", "users", column: "attendee_id"
end
