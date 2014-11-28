# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  msg         :string(255)
#  user_id     :integer
#  favority_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
	
	belongs_to :users, :class_name => "User", foreign_key: "user_id"
	belongs_to :favorites, :class_name => "Favorite", foreign_key: "favority_id"

	after_create do 
		f=self.favorites
		f.comment_sum+=1
		f.save
	end
end
