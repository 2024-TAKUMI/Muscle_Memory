class AddRemoveImageToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :remove_image, :boolean, default: false
  end
end
