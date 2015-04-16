class AddAvatarsToUsers < ActiveRecord::Migration
  def self.up
  	add_attachment :users, :avatar
#    change_table :users do |t|
#      t.attachment :avatar
#    end
  end

  def self.down
    drop_attached_file :users, :avatar
  end
end
