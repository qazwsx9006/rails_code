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
#

class Favorite < ActiveRecord::Base

	has_attached_file	:pic, 
						:styles => { :medium => "200x200>", :thumb => "50x50>" }, 
						:default_url => "/assets/missing.jpg",
					    :url => "/favorities/:id/:style/:filename",
					    :path => ":rails_root/public:url"
	validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/
	belongs_to :users, foreign_key: "user_id"

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

end
