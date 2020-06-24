# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_24_120400) do

  create_table "contacts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "contacted_at", null: false
    t.integer "way", null: false
    t.integer "purpose", null: false
    t.string "subject", null: false
    t.text "content", null: false
    t.integer "target", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_contacts_on_customer_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.integer "contract_status", default: 0, null: false
    t.string "name", default: "", null: false
    t.string "postal_code", default: ""
    t.integer "prefecture_id", null: false
    t.string "city", null: false
    t.string "address1", null: false
    t.string "address2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_status"], name: "index_customers_on_contract_status"
    t.index ["name"], name: "index_customers_on_name"
    t.index ["prefecture_id"], name: "index_customers_on_prefecture_id"
    t.index ["tenant_id"], name: "index_customers_on_tenant_id"
  end

  create_table "daily_reports", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "problem"
    t.string "improvement"
    t.string "consultation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_daily_reports_on_user_id"
  end

  create_table "ips", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.string "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tenant_id"], name: "index_ips_on_tenant_id"
  end

  create_table "tenants", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "postal_code", null: false
    t.integer "prefecture_id", null: false
    t.string "city", null: false
    t.string "address1", null: false
    t.string "address2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "image"
    t.string "email", null: false
    t.date "birthday", null: false
    t.boolean "sex", null: false
    t.boolean "administrator", default: false, null: false
    t.boolean "disable", default: false, null: false
    t.integer "prefecture_id"
    t.bigint "tenant_id", null: false
    t.bigint "manager_id"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["manager_id"], name: "index_users_on_manager_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tenant_id"], name: "index_users_on_tenant_id"
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "contacts", "customers"
  add_foreign_key "contacts", "users"
  add_foreign_key "customers", "tenants"
  add_foreign_key "daily_reports", "users"
  add_foreign_key "ips", "tenants"
  add_foreign_key "users", "tenants"
end