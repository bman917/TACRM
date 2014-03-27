class CreateAdminUser < ActiveRecord::Migration
  def up
  	user = User.where(username: 'admin').first
  	if user
  		user.role = 'Admin'
  		user.save!
  	end
  end
end