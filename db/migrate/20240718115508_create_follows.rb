class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|

      t.integer :followers_id, null: false, default: "" # フォロワーid
      t.integer :followee_id, null: false, default: "" # フォロイーid
      
      t.timestamps
    end
  end
end
