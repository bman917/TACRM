if %w(development).include?(Rails.env)
  Rack::MiniProfiler.config.pre_authorize_cb = lambda {|env| true } 
end