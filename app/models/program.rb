class Program < ApplicationRecord
  has_many :program_trackers #, dependent: :destroy
  # dependent: :destroy (see above) --> uncomment to permit admin to delete program that has program_trackers and users
  has_many :users, through: :program_trackers
  has_many :daily_workouts
  # has_many :program_rewards
  # has_many :rewards, through: :program_rewards
  has_many :rewards
end
