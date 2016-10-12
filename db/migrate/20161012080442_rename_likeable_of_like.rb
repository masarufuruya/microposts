class RenameLikeableOfLike < ActiveRecord::Migration
  def change
    rename_column :likes, :likeable_id, :issueable_id
    rename_column :likes, :likeable_type, :issueable_type
  end
end
