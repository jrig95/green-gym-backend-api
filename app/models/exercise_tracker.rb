class ExerciseTracker < ApplicationRecord
  belongs_to :daily_workout_tracker
  belongs_to :exercise


  # validates :number_of_reps, presence: true
  validates :daily_workout_tracker_id, presence: true
  validates :exercise_id, presence: true

  scope :match_user, -> (user_dwt_ids) { where daily_workout_tracker_id: user_dwt_ids}
end
