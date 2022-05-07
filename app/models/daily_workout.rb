class DailyWorkout < ApplicationRecord
  belongs_to :program
  has_many :exercises, dependent: :destroy

  scope :match_user, ->(user) { where(program_id: user) }
end
