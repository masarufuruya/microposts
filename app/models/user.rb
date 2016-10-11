class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }
    #name require, max50
    validates :name, presence: true, length: { maximum: 50 }
    #email require, max 255, formatmail
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    #更新時にはhas_secure_passwordはパスワードが無くても更新出来るようになっているっぽい
    validates :password, length: { minimum: 6 }, allow_nil: true
    validates :description, length: { maximum: 255 }
    has_secure_password
    has_many :microposts

    # has_many :throughの関連に同一モデルを含む場合
    # User > RelationShip > User
    # RelationShipが2つのUserと関連づけられているが、外部キーをどう指定するか

    # A.外部キーをそれぞれ別に持たせ,class_name=>:クラス名とする
    # has_manyの第一引数でフォローしている人,フォローされている人で別々で扱える
    has_many :following_relationships, :class_name => "Relationship", :foreign_key => "follower_id", dependent: :destroy
    has_many :follower_relationships, :class_name => "Relationship", :foreign_key => "followed_id", dependent: :destroy
    
    # RelationShipを通して2つのUserを相互に関連付けるには？
    # A.:through =>:中間クラス名と:source=>:中間クラスを通して参照する参照名(belongs_toで自由につけられる。その場合は外部キーを自分で指定する)
    has_many :following_users, :through => :following_relationships, :source => :followed_user
    has_many :follower_users, :through => :follower_relationships, :source => :follower_user
    
    def follow(other_user)
        #現在のユーザーが指定ユーザーをフォローしていない場合はフォロー
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    def unfollow(other_user)
        #現在のユーザーがフォローしているユーザーから指定ユーザーをアンフォロー
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    #あるユーザーをフォローしているかどうか
    def following?(other_user)
        following_users.include?(other_user)
    end
    
    #自分とフォローしているユーザーの投稿を取得する
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
end
