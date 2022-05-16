class AddDailyWorkoutIdToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    add_reference :daily_workout_trackers, :daily_workout, null: false, foreign_key: true
  end
end
