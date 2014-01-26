json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :last_name, :middle_name, :birth_day, :gender
  json.url profile_url(profile, format: :json)
end
