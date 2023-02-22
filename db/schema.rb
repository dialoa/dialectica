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

ActiveRecord::Schema.define(version: 2023_02_22_130734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "author", default: ""
    t.text "content"
    t.string "title", default: ""
    t.date "published_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "latex", default: ""
    t.string "format", default: "html"
    t.text "keywords", default: ""
    t.text "description", default: ""
    t.bigint "issue_id"
    t.string "status", default: ""
    t.index ["issue_id"], name: "index_articles_on_issue_id"
  end

  create_table "bibtex_entries", force: :cascade do |t|
    t.text "content", default: ""
    t.bigint "bibtex_file_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.index ["ancestry"], name: "index_bibtex_entries_on_ancestry"
    t.index ["bibtex_file_id"], name: "index_bibtex_entries_on_bibtex_file_id"
  end

  create_table "bibtex_files", force: :cascade do |t|
    t.text "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "code_id"
    t.index ["code_id"], name: "index_bibtex_files_on_code_id"
  end

  create_table "blocked_users", force: :cascade do |t|
    t.bigint "submission_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["submission_id"], name: "index_blocked_users_on_submission_id"
    t.index ["user_id"], name: "index_blocked_users_on_user_id"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title", default: ""
    t.text "description", default: ""
    t.text "keywords", default: ""
    t.text "search_field", default: ""
    t.text "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.string "category", default: ""
    t.bigint "user_id"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_blog_posts_on_user_id"
  end

  create_table "codes", force: :cascade do |t|
    t.text "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "bibtex", default: ""
    t.string "name", default: ""
    t.text "yaml", default: ""
  end

  create_table "email_templates", force: :cascade do |t|
    t.text "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", default: ""
  end

  create_table "external_referee_submissions", force: :cascade do |t|
    t.bigint "external_referee_id"
    t.bigint "submission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "no answer"
    t.date "date_of_answer"
    t.index ["external_referee_id"], name: "index_external_referee_submissions_on_external_referee_id"
    t.index ["submission_id"], name: "index_external_referee_submissions_on_submission_id"
  end

  create_table "external_referees", force: :cascade do |t|
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.string "email", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "histories", force: :cascade do |t|
    t.text "content", default: ""
    t.bigint "submission_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "alternative_name", default: ""
    t.text "search_field", default: ""
    t.string "category", default: ""
    t.index ["submission_id"], name: "index_histories_on_submission_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.string "title", default: ""
    t.date "published_at"
    t.text "description", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jsons", force: :cascade do |t|
    t.jsonb "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ancestry"
    t.bigint "bibtex_entry_id"
    t.index ["ancestry"], name: "index_jsons_on_ancestry"
    t.index ["bibtex_entry_id"], name: "index_jsons_on_bibtex_entry_id"
  end

  create_table "media", force: :cascade do |t|
    t.text "comment"
    t.string "mediumable_type"
    t.bigint "mediumable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mediumable_type", "mediumable_id"], name: "index_media_on_mediumable_type_and_mediumable_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title", default: ""
    t.text "description", default: ""
    t.text "keywords", default: ""
    t.text "search_field", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.text "content", default: ""
    t.integer "sort", default: 0
    t.string "status", default: "visible"
    t.string "special_page", default: ""
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "question_answers", force: :cascade do |t|
    t.text "question", default: ""
    t.text "answer", default: ""
    t.bigint "submission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["submission_id"], name: "index_question_answers_on_submission_id"
  end

  create_table "reports", force: :cascade do |t|
    t.text "content", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "submission_id"
    t.bigint "user_id"
    t.index ["submission_id"], name: "index_reports_on_submission_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "requested_reviewers", force: :cascade do |t|
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.string "email", default: ""
    t.string "status", default: "open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "submission_id", null: false
    t.index ["submission_id"], name: "index_requested_reviewers_on_submission_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stuffs", force: :cascade do |t|
    t.string "filename", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "error", default: ""
    t.text "comment", default: ""
  end

  create_table "submission_users", force: :cascade do |t|
    t.bigint "submission_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["submission_id"], name: "index_submission_users_on_submission_id"
    t.index ["user_id"], name: "index_submission_users_on_user_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.string "title", default: ""
    t.string "area", default: ""
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status", default: "submitted"
    t.string "email", default: ""
    t.text "history", default: ""
    t.string "proposed", default: "false"
    t.string "dead", default: "false"
    t.string "country", default: ""
    t.string "gender", default: ""
    t.string "other_authors", default: ""
    t.text "comment", default: ""
    t.date "appearance_date"
    t.integer "submitted_by_user_id"
    t.string "proposed_for_acceptance", default: "false"
    t.string "proposed_for_rejection", default: "false"
    t.string "accepted", default: "false"
    t.string "rejected", default: "false"
    t.text "search_field", default: ""
    t.integer "dialectica_id"
    t.string "withdrawn", default: "false"
    t.integer "resubmit_original_dialectica_id"
    t.string "proposed_for_discussion", default: ""
    t.string "extended_appearance_date_for_send_to_external_referee", default: "false"
  end

  create_table "suggestion_submissions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "submission_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["submission_id"], name: "index_suggestion_submissions_on_submission_id"
    t.index ["user_id"], name: "index_suggestion_submissions_on_user_id"
  end

  create_table "user_codes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "code_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code_id"], name: "index_user_codes_on_code_id"
    t.index ["user_id"], name: "index_user_codes_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "firstname", default: ""
    t.string "lastname", default: ""
    t.string "username"
    t.string "notify_me_when_i_am_suggested_as_an_internal_referee", default: "no"
    t.string "notify_me_when_something_happens_to_my_fish", default: "no"
    t.string "hidden", default: "no"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "web_site_contents", force: :cascade do |t|
    t.string "title", default: ""
    t.text "content", default: ""
    t.string "identifier", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bibtex_files", "codes"
  add_foreign_key "blog_posts", "users"
  add_foreign_key "jsons", "bibtex_entries"
  add_foreign_key "reports", "submissions"
  add_foreign_key "reports", "users"
  add_foreign_key "requested_reviewers", "submissions"
end
