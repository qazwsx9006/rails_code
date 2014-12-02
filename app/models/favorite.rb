# == Schema Information
#
# Table name: favorites
#
#  id               :integer          not null, primary key
#  msg              :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#  store_name       :string(255)
#  coodinate_x      :string(255)
#  coodinate_y      :string(255)
#  address          :string(255)
#  pic_file_name    :string(255)
#  pic_content_type :string(255)
#  pic_file_size    :integer
#  pic_updated_at   :datetime
#  latitude         :float
#  longitude        :float
#  comment_sum      :integer          default(0)
#

class Favorite < ActiveRecord::Base

	has_attached_file	:pic, 
						:styles => { :medium => "200x200>", :thumb => "50x50>" }, 
						:default_url => "/assets/missing.jpg",
					    :url => "/favorities/:id/:style/:filename",
					    :path => ":rails_root/public:url"
	validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/
	
	has_many :comments , foreign_key: "favority_id"
	belongs_to :users, :class_name => "User", foreign_key: "user_id"

	has_many :likes, :class_name => 'Like', :foreign_key => 'favorite_id', :dependent => :destroy

	geocoded_by :address
	after_validation :geocode 
	reverse_geocoded_by :latitude, :longitude
	reverse_geocoded_by :latitude, :longitude do |obj,results|
	  if geo = results.first
	  	str=geo.address
	  	zip=str.at(/[0-9]{0,}/)
	    obj.address = "#{str[zip.length,str.length]}"
	  end
	end
	after_validation :reverse_geocode  

	def like(user)
		l=self.likes.new
		l.user_id=user.id
		l.save
	end
	def unlike(user)
		self.likes.where(user_id: user.id).first.delete
	end
	def like?(user)
		!self.likes.where(user_id: user.id).blank?
	end

	def likes_count
		@likes_count ||= self.likes.count
	end
end
