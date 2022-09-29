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

ActiveRecord::Schema[7.0].define(version: 2022_09_26_113443) do
  create_table "abuse_reports", force: :cascade do |t|
    t.string "abuse_reportable_type", null: false
    t.integer "abuse_reportable_id", null: false
    t.string "reason", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abuse_reportable_type", "abuse_reportable_id"], name: "index_abuse_reports_on_abuse_reportable"
    t.index ["user_id"], name: "index_abuse_reports_on_user_id"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_upvotes", default: 0
    t.integer "total_downvotes", default: 0
    t.datetime "published_at", precision: nil
    t.datetime "disabled_at", precision: nil
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "api_request_logs", force: :cascade do |t|
    t.string "endpoint"
    t.string "ip_address"
    t.datetime "created_at", precision: nil
  end

  create_table "comments", force: :cascade do |t|
    t.string "content", null: false
    t.string "commentable_type", null: false
    t.integer "commentable_id", null: false
    t.integer "total_upvotes", default: 0
    t.integer "total_downvotes", default: 0
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at", precision: nil
    t.datetime "disabled_at", precision: nil
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "credit_packs", force: :cascade do |t|
    t.decimal "price", precision: 8, scale: 2
    t.integer "credits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_transactions", force: :cascade do |t|
    t.integer "value", null: false
    t.string "reason"
    t.integer "transaction_type", null: false
    t.integer "user_id"
    t.string "entity_type"
    t.integer "entity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity_type", "entity_id"], name: "index_credit_transactions_on_entity"
    t.index ["user_id"], name: "index_credit_transactions_on_user_id"
  end

  create_table "follows", primary_key: ["followee_id", "follower_id"], force: :cascade do |t|
    t.integer "followee_id", null: false
    t.integer "follower_id", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "content"
    t.boolean "sent", default: false
    t.string "notifiable_type", null: false
    t.integer "notifiable_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "read_at", precision: nil
    t.index ["notifiable_type", "notifiable_id"], name: "index_notifications_on_notifiable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "order_transactions", force: :cascade do |t|
    t.string "transaction_id", null: false
    t.decimal "amount", null: false
    t.string "payment_method", null: false
    t.string "payment_status", null: false
    t.string "reason"
    t.string "status"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_transactions_on_order_id"
    t.index ["transaction_id"], name: "index_order_transactions_on_transaction_id", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "amount", null: false
    t.integer "status", null: false
    t.string "code", null: false
    t.integer "credit_pack_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credit_pack_id"], name: "index_orders_on_credit_pack_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.integer "total_upvotes", default: 0
    t.integer "total_downvotes", default: 0
    t.string "permalink"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at", precision: nil
    t.datetime "disabled_at", precision: nil
    t.index ["permalink"], name: "index_questions_on_permalink", unique: true
    t.index ["title"], name: "index_questions_on_title", unique: true
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "role", default: 1
    t.string "confirmation_token"
    t.string "password_reset_token"
    t.datetime "verified_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "disabled_at", precision: nil
    t.integer "credits", default: 0, null: false
    t.string "username"
    t.string "auth_token"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.integer "vote", null: false
    t.integer "user_id", null: false
    t.string "voteable_type", null: false
    t.integer "voteable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["voteable_type", "voteable_id"], name: "index_votes_on_voteable"
  end

  add_foreign_key "abuse_reports", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "credit_transactions", "users"
  add_foreign_key "follows", "users", column: "followee_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "order_transactions", "orders"
  add_foreign_key "orders", "credit_packs"
  add_foreign_key "orders", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "votes", "users"
end
