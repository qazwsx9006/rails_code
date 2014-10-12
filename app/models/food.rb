# == Schema Information
#
# Table name: foods
#
#  id          :integer          not null, primary key
#  pic         :string(255)
#  name        :string(255)
#  coodinate_x :string(255)
#  coodinate_y :string(255)
#  address     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Food < ActiveRecord::Base
end
