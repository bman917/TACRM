module ProfilesHelper

	def self.cache_key_for_profiles
	    count          = Profile.count
	    max_updated_at = Profile.maximum(:updated_at).try(:utc).try(:to_s, :number)
	    "profile/all-#{count}-#{max_updated_at}"
	end

end
