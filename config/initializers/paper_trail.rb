module PaperTrail
  class Version < ActiveRecord::Base
  	belongs_to :profile

  	def profile_index
  		PaperTrail::Version.where(profile_id: self.profile_id).index(self)
  	end

  	def display
  		description || item_type

  	end
    
  end
end