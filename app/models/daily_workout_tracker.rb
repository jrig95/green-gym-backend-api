class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :user
end
