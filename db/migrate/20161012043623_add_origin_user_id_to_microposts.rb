class AddOriginUserIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :origin_user_id, :integer
  end
end
