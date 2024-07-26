class AddViewsCountAndCommentsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :views_count, :integer
    add_column :posts, :comments_count, :integer
  end
end
