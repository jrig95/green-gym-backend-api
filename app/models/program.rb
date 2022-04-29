class Program < ApplicationRecord
  has_many :program_trackers
  has_many :users, through: :program_trackers
end
