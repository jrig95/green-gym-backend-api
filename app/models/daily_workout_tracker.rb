class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :daily_workout
end
