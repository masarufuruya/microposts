class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :likes, as: :issueable
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  paginates_per 5
  
  def favorite?(user)
    likes.where(user_id: user.id).any?
  end
end
