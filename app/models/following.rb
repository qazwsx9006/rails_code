# == Schema Information
#
# Table name: followings
#
#  id           :integer          not null, primary key
#  following_id :integer
#  followed_id  :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Following < ActiveRecord::Base
  belongs_to :followed, :class_name => 'User', :foreign_key => 'following_id'
  belongs_to :follow_user, :class_name => 'User', :foreign_key => 'followed_id'
end
