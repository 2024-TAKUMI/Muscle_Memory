class AddParentToGenres < ActiveRecord::Migration[6.1]
  def change
    add_reference :genres, :parent, foreign_key: { to_table: :genres }
  end
end
