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
  has_many :groups, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  has_one_attached :profile_img

  has_and_belongs_to_many :joined_groups, class_name: 'Group', join_table: 'groups_users'

  def get_profile_image
    if profile_img.attached?
      profile_img
    else
      'no_image.jpg'
    end
  end
end
