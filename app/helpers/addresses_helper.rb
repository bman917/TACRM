module AddressesHelper
	def self.cache_key_for_addresses
	    count          = Address.count
	    max_updated_at = Address.maximum(:updated_at).try(:utc).try(:to_s, :number)
	    "address/all-#{count}-#{max_updated_at}"
	end
end
