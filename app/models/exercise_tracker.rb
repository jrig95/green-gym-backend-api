class ExerciseTracker < ApplicationRecord
  belongs_to :daily_workout_tracker
  belongs_to :exercise

  scope :match_user, -> (user_dwt_ids) { where daily_workout_tracker_id: user_dwt_ids}
end
