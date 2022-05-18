class Program < ApplicationRecord

  has_one_attached :photo
  has_many :program_trackers, dependent: :destroy
  # dependent: :destroy (see above) --> uncomment to permit admin to delete program that has program_trackers and users
  has_many :users, through: :program_trackers
  has_many :daily_workouts, dependent: :destroy
  has_many :rewards

  validates :program_title, presence: true
  validates :program_description, presence: true
  validates :number_of_days, presence: true
  validates :price, presence: true
end
