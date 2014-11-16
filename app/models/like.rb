# == Schema Information
#
# Table name: likes
#
#  id          :integer          not null, primary key
#  favorite_id :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Like < ActiveRecord::Base
	belongs_to :users, :class_name => "User", foreign_key: "user_id"
	belongs_to :favorites, :class_name => "Favorite", foreign_key: "favorite_id"
end
