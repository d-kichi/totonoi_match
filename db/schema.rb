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

ActiveRecord::Schema[7.1].define(version: 2025_11_03_065118) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.integer "score"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "style_type"
    t.string "value_type"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "diagnosis_answers", force: :cascade do |t|
    t.bigint "result_id", null: false
    t.bigint "question_id", null: false
    t.bigint "answer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_diagnosis_answers_on_answer_id"
    t.index ["question_id"], name: "index_diagnosis_answers_on_question_id"
    t.index ["result_id"], name: "index_diagnosis_answers_on_result_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results", force: :cascade do |t|
    t.bigint "sauna_type_id", null: false
    t.string "headline"
    t.text "body"
    t.text "recommendation_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sauna_type_id"], name: "index_results_on_sauna_type_id"
  end

  create_table "sauna_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saunas", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.integer "temperature"
    t.integer "water_temp"
    t.boolean "has_outdoor_bath"
    t.time "open_time"
    t.time "close_time"
    t.text "description"
    t.bigint "sauna_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sauna_type_id"], name: "index_saunas_on_sauna_type_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "diagnosis_answers", "answers"
  add_foreign_key "diagnosis_answers", "questions"
  add_foreign_key "diagnosis_answers", "results"
  add_foreign_key "results", "sauna_types"
  add_foreign_key "saunas", "sauna_types"
end
