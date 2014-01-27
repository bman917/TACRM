json.array!(@addresses) do |address|
  json.extract! address, :id, :owner_id, :line_one, :city, :state_region, :zipcode, :country
  json.url address_url(address, format: :json)
end
