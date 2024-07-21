class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :subgenre, class_name: 'Genre', optional: true
  has_one_attached :image

  validates :title, :body, :genre_id, presence: true
end
