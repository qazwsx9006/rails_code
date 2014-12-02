# == Schema Information
#
# Table name: gacs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  age        :integer
#  grade      :integer
#  add        :string(255)
#  phone      :string(255)
#  fb         :string(255)
#  line       :string(255)
#  other      :text
#  created_at :datetime
#  updated_at :datetime
#

class Gac < ActiveRecord::Base
	has_many :actions, :class_name => 'Action', :foreign_key => 'gac_id', :dependent => :destroy
end
