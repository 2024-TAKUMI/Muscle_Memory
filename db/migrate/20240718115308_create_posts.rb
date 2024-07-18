class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.string :post_search, null: false, default: "" # 検索機能
      t.boolean :is_active, null: false, default: "TRUE" # 有効会員フラグ
      
      t.timestamps
    end
  end
end
