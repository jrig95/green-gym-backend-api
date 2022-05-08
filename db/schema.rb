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

ActiveRecord::Schema.define(version: 2022_05_08_085430) do

  create_table "daily_workout_trackers", force: :cascade do |t|
    t.boolean "dwt_check_in"
    t.boolean "dwt_daily_challenge"
    t.integer "program_tracker_id", null: false
    t.integer "daily_workout_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["daily_workout_id"], name: "index_daily_workout_trackers_on_daily_workout_id"
    t.index ["program_tracker_id", "daily_workout_id"], name: "dwt_id_pt_id_index", unique: true
    t.index ["program_tracker_id"], name: "index_daily_workout_trackers_on_program_tracker_id"
  end

  create_table "daily_workouts", force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "day_number"
    t.string "daily_challenge_title"
    t.text "daily_challenge_description"
    t.integer "number_of_exercises"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_daily_workouts_on_program_id"
  end

  create_table "exercise_trackers", force: :cascade do |t|
    t.integer "number_of_reps"
    t.integer "daily_workout_tracker_id", null: false
    t.integer "exercise_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["daily_workout_tracker_id"], name: "index_exercise_trackers_on_daily_workout_tracker_id"
    t.index ["exercise_id"], name: "index_exercise_trackers_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "exercise_title"
    t.boolean "exercise_question"
    t.string "exercise_work_time"
    t.string "exercise_rest_time"
    t.integer "calories_per_exercise"
    t.integer "daily_workout_id", null: false
    t.integer "library_item_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["daily_workout_id"], name: "index_exercises_on_daily_workout_id"
    t.index ["library_item_id"], name: "index_exercises_on_library_item_id"
  end

  create_table "library_items", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "program_trackers", force: :cascade do |t|
    t.integer "program_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["program_id"], name: "index_program_trackers_on_program_id"
    t.index ["user_id"], name: "index_program_trackers_on_user_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string "program_title"
    t.text "program_description"
    t.integer "number_of_days"
    t.string "program_cover_image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "reward_name"
    t.string "reward_image"
    t.integer "reward_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "program_id"
    t.boolean "visible"
    t.index ["program_id"], name: "index_rewards_on_program_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "admin"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "daily_workout_trackers", "daily_workouts"
  add_foreign_key "daily_workout_trackers", "program_trackers"
  add_foreign_key "daily_workouts", "programs"
  add_foreign_key "exercise_trackers", "daily_workout_trackers"
  add_foreign_key "exercise_trackers", "exercises"
  add_foreign_key "exercises", "daily_workouts"
  add_foreign_key "exercises", "library_items"
  add_foreign_key "program_trackers", "programs"
  add_foreign_key "program_trackers", "users"
end
