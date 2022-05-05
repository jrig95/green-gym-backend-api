class CreateDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_workout_trackers do |t|
      t.boolean :dwt_check_in
      t.boolean :dwt_daily_challenge
      t.integer :dwt_day_number
      t.references :program_tracker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
