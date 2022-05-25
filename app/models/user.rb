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
  has_many :reward_trackers, dependent: :destroy
  has_many :rewards, through: :reward_trackers, dependent: :destroy

  # validates :first_name, presence: true

  before_create :set_default_avatar

  def set_default_avatar
    self.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpg')), filename: 'default-avatar.jpg', content_type: 'image/jpg')
  end

end
