# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  pic        :string(255)
#  msg        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Favorite < ActiveRecord::Base
end
