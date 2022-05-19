class RemoveDwtDailyChallengeFromDailyWorkoutTrackers < ActiveRecord::Migration[6.1]
  def change
    remove_column :daily_workout_trackers,:dwt_aily_challenge, :boolean
  end
end
