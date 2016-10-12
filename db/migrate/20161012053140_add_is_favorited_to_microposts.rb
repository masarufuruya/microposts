class AddIsFavoritedToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :is_favorited, :boolean, default: false, null: false
  end
end
