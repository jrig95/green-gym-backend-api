class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :photo
  # attr_accessor :first_name, :last_name, :user_company, :user_gender, :user_fitness_level, :user_passions, :user_total_calories, :user_points, :admin

  include Devise::JWT::RevocationStrategies::JTIMatcher

  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :program_trackers, dependent: :destroy
  has_many :programs, through: :program_trackers, dependent: :destroy
  # validates :first_name, presence: true
end
