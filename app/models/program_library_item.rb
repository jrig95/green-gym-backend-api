class ProgramLibraryItem < ApplicationRecord
  has_one_attached :photo
  has_one_attached :video
  has_many :programs, dependent: :destroy
  has_many :daily_workouts, dependent: :destroy

  validates :pli_title, presence: true
  acts_as_taggable_on :tags
end
