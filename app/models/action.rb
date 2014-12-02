# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  gac_id     :integer
#  join       :boolean
#

class Action < ActiveRecord::Base
	belongs_to :gacs, :class_name => "Gac", foreign_key: "gac_id"
end
