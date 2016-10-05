class RenameFollowerdIdColumnToRelationships < ActiveRecord::Migration
  def change
    rename_column :relation_ships, :followerd_id, :followed_id
  end
end
