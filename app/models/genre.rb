class Genre < ApplicationRecord
  has_many :subgenres, class_name: "Genre", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Genre", optional: true

  validates :name, presence: true
end
