class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :self_introduction, length: { maximum: 500 }

  has_many :posts
  has_many :post_comments, dependent: :destroy
  has_many :likes
  
  has_one_attached :profile_img

  def get_profile_image
    if profile_img.attached?
      profile_img
    else
      'no_image.jpg'
    end
  end
end
