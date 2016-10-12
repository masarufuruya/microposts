class RemoveOrginUserIdFromMicroposts < ActiveRecord::Migration
  def up
    remove_column :microposts, :origin_user_id
  end
  def down
    add_column :microposts, :origin_user_id, :integer
  end
end
