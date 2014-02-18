module PhonesHelper
	def self.cache_key_for_phones
	    count          = Phone.count
	    max_updated_at = Phone.maximum(:updated_at).try(:utc).try(:to_s, :number)
	    "phone/all-#{count}-#{max_updated_at}"
	end
end
