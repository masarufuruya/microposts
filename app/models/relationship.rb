class Relationship < ActiveRecord::Base
  #Relationshipから所属しているUserへの参照
  #勉強のため、参照名を外部キー同じにしていないので自分で指定してる
  belongs_to :follower_user, class_name: "User", foreign_key: "follower_id"
  belongs_to :followed_user, class_name: "User", foreign_key: "followed_id"
end
