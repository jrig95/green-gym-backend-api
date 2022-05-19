class AddDwtDailyChallengeToDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    add_column :daily_workout_trackers, :dwt_daily_challenge, :boolean
  end
end
