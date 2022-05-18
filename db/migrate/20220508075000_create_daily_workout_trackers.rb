class CreateDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :daily_workout_trackers do |t|
      t.boolean :dwt_check_in
      t.boolean :dwt_aily_challenge
      t.references :program_tracker, null: false, foreign_key: true
      t.references :daily_workout, null: false, foreign_key: true

      t.timestamps
    end
  end
end
