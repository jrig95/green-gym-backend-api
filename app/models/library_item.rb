class LibraryItem < ApplicationRecord
  has_many :exercises, dependent: :destroy
end
