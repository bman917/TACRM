CarrierWave.configure do |config|
  # These permissions will make dir and files available only to the user running
  # the servers
  config.permissions = 0600
  config.directory_permissions = 0700
  config.storage = :file
  # This avoids uploaded files from saving to public/ and so
  # they will not be available for public (non-authenticated) downloading
  if %w(test).include?(Rails.env)
    config.root = Rails.root
  else
    config.root = "/uploads/#{Rails.env}"
  end
end