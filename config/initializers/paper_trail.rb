module PaperTrail
  class Version < ActiveRecord::Base
  	belongs_to :profile
  	belongs_to :user, class_name: "User", foreign_key: "whodunnit"

  	def profile_index
  		PaperTrail::Version.where(profile_id: self.profile_id).index(self)
  	end

  	def display
  		description || item_type

  	end

  	def user_name
  		user.try(:username) || "system"
  	end
    
  end
end