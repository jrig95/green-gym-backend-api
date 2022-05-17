class LibraryItem < ApplicationRecord
  has_one_attached :video
  has_many :exercises, dependent: :destroy
  validates :title, presence: true
end
