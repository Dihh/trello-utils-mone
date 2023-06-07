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

ActiveRecord::Schema[7.0].define(version: 2023_06_06_224517) do
  create_table "analyses", force: :cascade do |t|
    t.string "name"
    t.string "board_id"
    t.text "pre_planning"
    t.text "pos_planning"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "analyses_lists", id: false, force: :cascade do |t|
    t.integer "analysis_id"
    t.string "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "analysis_dates", force: :cascade do |t|
    t.date "date"
    t.integer "analysis_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_id"], name: "index_analysis_dates_on_analysis_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trello_id"
    t.integer "user_id"
    t.string "short_link"
  end

  create_table "date_values", force: :cascade do |t|
    t.integer "analysis_date_id", null: false
    t.integer "list_id", null: false
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analysis_date_id"], name: "index_date_values_on_analysis_date_id"
    t.index ["list_id"], name: "index_date_values_on_list_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "name"
    t.string "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trello_id"
  end

  create_table "labels_recurrent_cards", id: false, force: :cascade do |t|
    t.string "recurrent_card_id"
    t.string "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "name"
    t.string "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trello_id"
  end

  create_table "lists_recurrent_cards", id: false, force: :cascade do |t|
    t.string "recurrent_card_id", null: false
    t.string "list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recurrent_cards", force: :cascade do |t|
    t.string "name"
    t.string "board_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
  end

  add_foreign_key "analyses", "boards"
  add_foreign_key "analyses_lists", "analyses"
  add_foreign_key "analyses_lists", "lists"
  add_foreign_key "analysis_dates", "analyses"
  add_foreign_key "boards", "users"
  add_foreign_key "date_values", "analysis_dates"
  add_foreign_key "date_values", "lists"
  add_foreign_key "labels", "boards"
  add_foreign_key "labels_recurrent_cards", "labels"
  add_foreign_key "labels_recurrent_cards", "recurrent_cards"
  add_foreign_key "lists", "boards"
  add_foreign_key "lists_recurrent_cards", "lists"
  add_foreign_key "lists_recurrent_cards", "recurrent_cards"
  add_foreign_key "recurrent_cards", "boards"
end
