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

ActiveRecord::Schema.define(version: 2022_04_17_033538) do

  create_table "feedback_items", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "author_id", null: false
    t.integer "target_id", null: false
    t.integer "participation"
    t.integer "quality"
    t.integer "disagreements"
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"project\"", name: "index_feedback_items_on_project"
    t.index "\"taget_id\"", name: "index_feedback_items_on_taget_id"
    t.index ["author_id"], name: "index_feedback_items_on_author_id"
    t.index ["project_id"], name: "index_feedback_items_on_project_id"
    t.index ["target_id"], name: "index_feedback_items_on_target_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "students_id"
    t.integer "feedback_items_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feedback_items_id"], name: "index_groups_on_feedback_items_id"
    t.index ["students_id"], name: "index_groups_on_students_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "signed", default: false
    t.string "password_digest"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.boolean "is_open"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "signed", default: false
  end

  add_foreign_key "feedback_items", "authors"
  add_foreign_key "feedback_items", "projects"
  add_foreign_key "feedback_items", "targets"
end
