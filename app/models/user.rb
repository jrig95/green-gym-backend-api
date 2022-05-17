class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :photo

  include Devise::JWT::RevocationStrategies::JTIMatcher

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :program_trackers, dependent: :destroy
  has_many :programs, through: :program_trackers, dependent: :destroy
end
