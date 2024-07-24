class CreatePostcomments < ActiveRecord::Migration[6.1]
  def change
    create_table :postcomments do |t|

      t.text :comment, null: false # コメント本文
      t.integer :post_image_id, null: false # コメントされた投稿画像のid
      
      t.timestamps
    end
  end
end
