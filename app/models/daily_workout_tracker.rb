class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :daily_workout
  has_many :exercise_trackers, dependent: :destroy

  # def initialize(name, width, length)
  #   @name = name
  #   @width, @length = width, length
  # end

  def percent_completed
    percent = 0
    @dwt_completed = self.dw
  end
end
