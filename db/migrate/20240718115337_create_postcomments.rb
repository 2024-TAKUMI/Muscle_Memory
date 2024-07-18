class CreatePostcomments < ActiveRecord::Migration[6.1]
  def change
    create_table :postcomments do |t|

      t.text :comment, null: false, default: "" # コメント本文
      t.integer :post_image_id, null: false, default: "" # コメントされた投稿画像のid
      
      t.timestamps
    end
  end
end
