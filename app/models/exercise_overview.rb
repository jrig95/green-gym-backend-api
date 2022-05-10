class ExerciseOverview < ApplicationRecord
  belongs_to :daily_workout

  validates :daily_workout_id, presence: true
  validates :number_of_sets, presence: true
  validates :daily_workout_id, presence: true



end
