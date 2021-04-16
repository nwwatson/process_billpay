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

ActiveRecord::Schema.define(version: 2021_04_16_153051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allocations", force: :cascade do |t|
    t.bigint "donor_id", null: false
    t.bigint "fund_id", null: false
    t.decimal "amount"
    t.integer "amount_in_cents"
    t.integer "frequency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["donor_id"], name: "index_allocations_on_donor_id"
    t.index ["fund_id"], name: "index_allocations_on_fund_id"
  end

  create_table "batches", force: :cascade do |t|
    t.bigint "planning_center_id", null: false
    t.string "description"
    t.datetime "committed_at"
    t.integer "total_cents"
    t.string "total_currency"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["planning_center_id"], name: "index_batches_on_planning_center_id"
  end

  create_table "donors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "phone"
    t.string "email"
    t.string "bluepay_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "planning_center_person_id"
    t.index ["planning_center_person_id"], name: "index_donors_on_planning_center_person_id"
  end

  create_table "funds", force: :cascade do |t|
    t.string "name"
    t.integer "planning_center_id"
    t.string "bluepay_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "planning_center_emails", force: :cascade do |t|
    t.bigint "planning_center_person_id", null: false
    t.bigint "planning_center_id"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_planning_center_emails_on_email"
    t.index ["planning_center_id"], name: "index_planning_center_emails_on_planning_center_id"
    t.index ["planning_center_person_id"], name: "index_planning_center_emails_on_planning_center_person_id"
  end

  create_table "planning_center_people", force: :cascade do |t|
    t.bigint "planning_center_id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["planning_center_id"], name: "index_planning_center_people_on_planning_center_id"
  end

  create_table "transaction_allocations", force: :cascade do |t|
    t.integer "donation_id", null: false
    t.bigint "allocation_id"
    t.bigint "fund_id", null: false
    t.decimal "amount", null: false
    t.decimal "amount_in_cents", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["allocation_id"], name: "index_transaction_allocations_on_allocation_id"
    t.index ["donation_id"], name: "index_transaction_allocations_on_donation_id"
    t.index ["fund_id"], name: "index_transaction_allocations_on_fund_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "donor_id", null: false
    t.bigint "bluepay_id"
    t.bigint "planning_center_id"
    t.string "payment_type"
    t.decimal "amount"
    t.string "status"
    t.string "message"
    t.bigint "rebilling_id"
    t.bigint "settlment_id"
    t.string "bank_name"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "phone"
    t.string "email"
    t.string "auth_code"
    t.string "first_name"
    t.string "last_name"
    t.string "memo"
    t.bigint "backend_id"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "processing_status", default: 0, null: false
    t.bigint "batch_id", null: false
    t.datetime "issue_date"
    t.datetime "settle_date"
    t.string "raw"
    t.index ["batch_id"], name: "index_transactions_on_batch_id"
    t.index ["bluepay_id"], name: "index_transactions_on_bluepay_id"
    t.index ["donor_id"], name: "index_transactions_on_donor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "allocations", "donors"
  add_foreign_key "allocations", "funds"
  add_foreign_key "donors", "planning_center_people"
  add_foreign_key "planning_center_emails", "planning_center_people"
  add_foreign_key "transaction_allocations", "allocations"
  add_foreign_key "transaction_allocations", "funds"
  add_foreign_key "transactions", "batches"
  add_foreign_key "transactions", "donors"
end
