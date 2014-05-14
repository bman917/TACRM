module ProfilesHelper

	def self.cache_key_for_profiles
	    count          = Profile.count
	    max_updated_at = Profile.maximum(:updated_at).try(:utc).try(:to_s, :number)
	    "profile/all-#{count}-#{max_updated_at}
	    -#{PhonesHelper.cache_key_for_phones}
	    -#{AddressesHelper.cache_key_for_addresses}"
	end

	def profile_form(partial_name, profile, f)
		render partial: "profiles/forms/#{partial_name}", locals: {profile: profile, f: f}
	end
end
