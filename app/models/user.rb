class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
	has_many :favorites, dependent: :destroy
	has_many :book_comments, dependent: :destroy
	
	# has_many :active_relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
	# has_many :passive_relationships, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy
	has_many :follower, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy #フォロー取得
	has_many :followed, class_name:"Relationship", foreign_key:"followed_id", dependent: :destroy #フォロワー取得
	# has_many :following, through: :active_relationships, source: :followed
	# has_many :followers, through: :passive_relationships, source: :follower
	has_many :following_user, through: :follower, source: :followed #自分がフォローしている人
	# following_userを命名。自分がフォローしているユーザ情報を取得。
	has_many :follower_user, through: :followed, source: :follower #自分をフォローしている人
	# 自分をフォローしているユーザ情報を取得。
	
	#ユーザーをフォローする
	def follow(user_id)
		follower.create(followed_id: user_id)
	end
	
	#ユーザーのフォローを外す
	def unfollow(user_id)
		follower.find_by(followed_id: user_id).destroy
	end
  
  #フォローしていればTrueを返す
  def following?(user)
  	following_user.include?(user)
  end
  
	def followed_by?(user)
	    following_user.include?(user)
	end
  
  attachment :profile_image, destroy: false

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
end
