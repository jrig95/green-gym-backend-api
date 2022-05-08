class ProgramTracker < ApplicationRecord
  belongs_to :program
  belongs_to :user
  has_many :daily_workout_trackers
end
