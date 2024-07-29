class Genre < ApplicationRecord
  has_many :subgenres, class_name: "Genre", foreign_key: :parent_id
  belongs_to :parent, class_name: "Genre", optional: true
  
  has_many :main_posts, class_name: "Post", foreign_key: :genre_id
  has_many :sub_posts, class_name: "Post", foreign_key: :subgenre_id
  
  validates :name, presence: true
  
  def posts
    Post.where(genre_id: self.id).or(Post.where(subgenre_id: self.id))
  end
end
