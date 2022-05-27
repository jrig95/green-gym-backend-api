class DailyWorkoutTracker < ApplicationRecord
  belongs_to :program_tracker
  belongs_to :daily_workout
  has_many :exercise_trackers, dependent: :destroy
  has_many :exercises, through: :exercise_tracker

  # def initialize(name, width, length)
  #   @name = name
  #   @width, @length = width, length
  # end

  def completed
    dwt_check_in? || dwt_daily_challenge? || completed_exercise_trackers
  end

  def completed_exercise_trackers
    submitted_exercise_trackers = []
    exercise_trackers.each  do |exercise_tracker|
      submitted_exercise_trackers << exercise_tracker.submitted
    end
    submitted_exercise_trackers.any?
  end
end

  # column in dwt boolean completed
  # current_day first dwt that is completed? false


  # current day method
  # all we are given is the user
  # we want to see the first dwt that has not been completed
  # dwt can have a submitted boolean?
  # dwt should also be able to come up with a percent completed, 33%, 66%, 100%
