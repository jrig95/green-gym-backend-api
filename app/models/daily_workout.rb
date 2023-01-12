class DailyWorkout < ApplicationRecord
  belongs_to :program
  has_many :exercises, dependent: :destroy
  has_many :exercise_overviews, dependent: :destroy
  has_many :daily_workout_trackers, dependent: :destroy
  belongs_to :program_library_item, required: false
  validates :program_id, presence: true
  validates :day_number, presence: true
  validates :daily_challenge_title, presence: true
  validates :daily_challenge_description, presence: true
  validates :description, presence: true
  validates :number_of_exercises, presence: true
  validates :day_number, uniqueness: { scope: :program_id }

  scope :match_user, ->(user) { where(program_id: user) }
end
