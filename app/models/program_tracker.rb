class ProgramTracker < ApplicationRecord
  belongs_to :program
  belongs_to :user
  has_many :daily_workout_trackers, dependent: :destroy
  has_many :daily_workouts, through: :program

  validates :program_id, presence: true
  validates :user_id, presence: true
  validates :program_id, uniqueness: { scope: :user_id }

end
