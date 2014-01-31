json.array!(@members) do |member|
  json.extract! member, :id, :profile_id, :group_id, :relationship
  json.url member_url(member, format: :json)
end
