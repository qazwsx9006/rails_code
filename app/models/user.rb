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

end
