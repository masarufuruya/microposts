class AddOrginUserIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :origin_user_id, :integer, after: :user_id
  end
end
