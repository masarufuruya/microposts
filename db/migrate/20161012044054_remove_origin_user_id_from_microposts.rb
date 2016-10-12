class RemoveOriginUserIdFromMicroposts < ActiveRecord::Migration
  def up
    remove_column :microposts, :origin_user_id
    add_column :microposts, :origin_user_id, :integer, :after => :user_id
  end
  def down
    remove_column :microposts, :origin_user_id
    add_column :microposts, :origin_user_id, :integer
  end
end

