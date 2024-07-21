class AddSubgenreToPosts < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :subgenre, foreign_key: { to_table: :genres }
  end
end
