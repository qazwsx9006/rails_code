# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  account             :string(255)
#  password_digest     :string(255)
#  nickname            :string(255)
#  mimi_t              :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  mood                :string(255)
#  about               :string(255)
#  info_bg             :string(255)
#  mood_at             :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  heart_sum           :integer          default(0)
#

class User < ActiveRecord::Base
	has_secure_password
	before_save { |user| user.account = account.downcase }

	has_attached_file	:avatar, 
						#:styles => { :medium => "300x300>", :thumb => "100x100>" }, 
						:styles => { :medium => "200x200#", :thumb => "50x50#" }, 
						:default_url => "/assets/default_avatar.jpg",
					    :url => "/avatars/:id/:style/:filename",
					    :path => ":rails_root/public:url"
						#:path => ":attachment/:id/:style/sss_:basename.:extension"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	has_many :favorites , foreign_key: "user_id"
	has_many :comments , foreign_key: "user_id"

	has_many :followed_relationships, :class_name => 'Following', :foreign_key => 'followed_id', :dependent => :destroy
 	has_many :follower_relationships, :class_name => 'Following', :foreign_key => 'following_id', :dependent => :destroy

 	has_many :followeds, :through => :followed_relationships
 	has_many :follow_users, :through => :follower_relationships

 	has_many :likes, :class_name => 'Like', :foreign_key => 'user_id', :dependent => :destroy

	validates :account, presence: true, uniqueness: { case_sensitive: false }
	validates :password, presence: true
	validates :password_confirmation, presence: true
	validates :nickname, presence: true, length: { maximum: 12 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	VALID_PW_REGEX = /\A[a-zA-Z]{1}[a-zA-Z0-9]{5,11}\z/ #密碼需為英數且開頭為英文。6~12碼
	validates :account, format: { with: VALID_EMAIL_REGEX }
	validates :password, format: { with: VALID_PW_REGEX }

	before_create do
		self.mimi_t = SecureRandom.urlsafe_base64() 
		self.mood_at = Time.now()
		self.mood = "I loke give_me_bite!"
	end
	before_save do
		if self.mood_changed?
			self.mood_at = Time.now()
		end
	end

	def avatar_url(size=:original)
		if self.avatar.blank?
			return "/assets/default_avatar.jpg"
		else
			return self.avatar.url(size)
		end
	end

  #follow	
  def follow(user)
    self.follow_users << user and true
  end

  def unfollow(user)
    user.followeds.delete(self) and true
  end

  def following?(user)
	self.follower_relationships.where(:followed_id => user.id).exists?
  end

  def followed_by?(user)
    self.followed_relationships.where(:following_id => user.id).exists?
  end

  def follower_count
    @follower_count ||= self.follower_relationships.count
  #  self.follower_relationships.count
  end

  def followed_count
    @followed_user_count ||= self.followed_relationships.count
  #  self.followed_relationships.count
  end

  def follower_ids
    @follower_ids ||= self.follower_relationships.collect(&:followed_id)
  end

  def followed_ids
    @followed_ids ||= self.followed_relationships.collect(&:following_id)
   # self.followed_relationships.collect(&:followed_user_id)
  end

  # def followed_topic_timeline(num=10)
  #   # FIXME: cache this result
  #   DiscusTopic.where(user_id: self.followed_user_ids, hide: false).order('created_at DESC').limit(num)
  # end
  # def recent_followers
  #   follower_ids = self.follower_relationships.order('created_at DESC').limit(10).pluck(:user_id)
  #   follower_ids.map { |uid| User.find_cached(uid) }
  # end


end
