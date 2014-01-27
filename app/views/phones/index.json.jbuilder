json.array!(@phones) do |phone|
  json.extract! phone, :id, :phone_type, :number, :contact_detail_id
  json.url phone_url(phone, format: :json)
end
