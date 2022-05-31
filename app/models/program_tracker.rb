class ProgramTracker < ApplicationRecord
  belongs_to :program
  belongs_to :user
  has_many :daily_workout_trackers, dependent: :destroy
  has_many :exercise_trackers, through: :daily_workout_trackers, dependent: :destroy
  has_many :daily_workouts, through: :program

  validates :program_id, presence: true
  validates :user_id, presence: true
  validates :program_id, uniqueness: { scope: :user_id }

  def sort_dwts
    daily_workout_trackers.sort { |a, b| a.id <=> b.id }
  end

  def sort_dwts_and_ets
    daily_workout_trackers.sort { |a, b| a.id <=> b.id }
    daily_workout_trackers.each do |dwt|
      dwt.exercise_trackers.sort { |a, b| a.id <=> b.id }
    end
  end
end
