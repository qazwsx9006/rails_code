# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  account         :string(255)
#  password_digest :string(255)
#  nickname        :string(255)
#  avatar          :string(255)
#  mimi_t          :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  mood            :string(255)
#  about           :string(255)
#  info_bg         :string(255)
#  mood_at         :datetime
#

class User < ActiveRecord::Base
	has_secure_password
	before_save { |user| user.account = account.downcase }

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

	def avatar_url
		if self.avatar.blank?
			return "/assets/default_avatar.jpg"
		else
			return self.avatar
		end
	end

end
