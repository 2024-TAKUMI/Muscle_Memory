class Like < ApplicationRecord
  has_many  :posts
  belongs_to :user
end