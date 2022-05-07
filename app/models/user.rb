class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :program_trackers, dependent: :destroy
  has_many :programs, through: :program_trackers
end
