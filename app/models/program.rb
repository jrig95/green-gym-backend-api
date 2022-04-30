class Program < ApplicationRecord
  has_many :program_trackers #, dependent: :destroy
  has_many :users, through: :program_trackers
end
