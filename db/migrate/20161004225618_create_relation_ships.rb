class CreateRelationShips < ActiveRecord::Migration
  def change
    create_table :relation_ships do |t|
      t.references :follower, index: true #index: trueで単体インデックス
      t.references :followerd, index: true

      t.timestamps null: false
      # これはunique制約をつけたくてインデックスをつけている？
      t.index [:follower_id, :followerd_id], unique: true
    end
  end
end
