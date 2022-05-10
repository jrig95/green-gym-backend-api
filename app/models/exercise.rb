class Exercise < ApplicationRecord
  belongs_to :daily_workout
  belongs_to :library_item
  has_many :exercise_trackers, dependent: :destroy
  scope :match_user, ->(user_dwt_ids) { where(daily_workout_id: user_dwt_ids) }

  validates :exercise_title, presence: true
  # validates :exercise_question, presence: true
  # validates :exercise_work_time, presence: true
  # validates :exercise_rest_time, presence: true
  # validates :calories_per_exercise, presence: true
  validates :daily_workout_id, presence: true
  validates :library_item_id, presence: true
end
