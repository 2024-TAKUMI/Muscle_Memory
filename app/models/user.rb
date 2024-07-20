class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  
  has_many :posts
  has_many :postcomments
  has_many :likes

  def get_profile_image(width, height)
    if profile_img.present?
      profile_img
    else
      'default_profile_image.png'
    end
  end
end