class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :daily_workout
  has_many :exercise_trackers
  validates :daily_workout_id, uniqueness: { scope: :program_tracker_id }
end
