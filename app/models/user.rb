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
end
