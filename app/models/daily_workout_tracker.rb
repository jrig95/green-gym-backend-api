class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :daily_workout
  has_many :exercise_trackers, dependent: :destroy
  has_many :exercises, through: :exercise_tracker

  # before_save :dwt_available?
  #   def dwt_available
  #     self.dwt_available = self.daily_workout.available
  #   end
end
