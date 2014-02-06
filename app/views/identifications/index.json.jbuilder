json.array!(@identifications) do |identification|
  json.extract! identification, :id, :type, :foid, :notes, :profile_id
  json.url identification_url(identification, format: :json)
end
