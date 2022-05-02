class Reward < ApplicationRecord
    has_many :program_rewards, dependent: :destroy
    has_many :programs, through: :program_rewards
end
