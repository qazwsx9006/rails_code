class AddAttachmentPicToFavorities < ActiveRecord::Migration
  def self.up
    change_table :favorites do |t|
      t.attachment :pic
    end
  end

  def self.down
    remove_attachment :favorites, :pic
  end
end
