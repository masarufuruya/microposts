class CreateFavoritePosts < ActiveRecord::Migration
  def change
    create_table :favorite_posts do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :is_favorited

      t.timestamps null: false
    end
  end
end
