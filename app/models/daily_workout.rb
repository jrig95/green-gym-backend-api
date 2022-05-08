class DailyWorkout < ApplicationRecord
  belongs_to :program
  has_many :exercises, dependent: :destroy
  has_many :daily_workout_trackers, dependent: :destroy

  scope :match_user, ->(user) { where(program_id: user) }
end
