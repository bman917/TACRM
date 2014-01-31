json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :profile_id
  json.url account_url(account, format: :json)
end
