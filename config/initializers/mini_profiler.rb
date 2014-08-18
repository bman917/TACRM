#if %w(development staging production).include?(Rails.env)
if %w(production).include?(Rails.env)
  Rack::MiniProfiler.config.pre_authorize_cb = lambda {|env| false } 
end