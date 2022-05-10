class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :daily_workout
  has_many :exercise_trackers, dependent: :destroy

  validates :program_tracker_id, presence: true
  validates :daily_workout_id, presence: true
  # validates :dwt_check_in, presence: true
  # validates :dwt_daily_challenge, presence: true


  validates :daily_workout_id, uniqueness: { scope: :program_tracker_id }
end
