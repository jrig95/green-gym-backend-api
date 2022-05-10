class ProgramTracker < ApplicationRecord
  belongs_to :program
  belongs_to :user
  has_many :daily_workout_trackers, dependent: :destroy

  validates :program_id, presence: true
  validates :user_id, presence: true


end
