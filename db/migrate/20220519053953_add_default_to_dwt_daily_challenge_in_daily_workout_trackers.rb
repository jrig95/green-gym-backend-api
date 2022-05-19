class AddDefaultToDwtDailyChallengeInDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    change_column :daily_workout_trackers, :dwt_daily_challenge, :boolean, :default => false
  end
end
