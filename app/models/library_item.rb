class LibraryItem < ApplicationRecord
  has_one_attached :photo
  has_one_attached :video
  has_many :exercises, dependent: :destroy
  validates :title, presence: true
  acts_as_taggable_on :tags
end
