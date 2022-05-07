class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :program, through: :program_tracker
end
