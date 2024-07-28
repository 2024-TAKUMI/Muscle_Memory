class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  belongs_to :subgenre, class_name: 'Genre', optional: true
  has_one_attached :image
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  validate :subgenre_combination

  def subgenre_combination
    return if genre.nil? || subgenre.nil?

    invalid_combinations = {
      "上半身" => ["太もも", "ふくらはぎ", "お尻"],
      "下半身" => ["肩", "胸", "背中", "お腹", "腕"]
    }

    if invalid_combinations[genre.name]&.include?(subgenre.name)
      errors.add(:subgenre, "はジャンル「#{genre.name}」と組み合わせることはできません。")
    end
  end
end
