class Exercise < ApplicationRecord
  belongs_to :daily_workout
  belongs_to :library_item
  scope :match_user, ->(user_dwt_ids) { where(daily_workout_id: user_dwt_ids) }
end
