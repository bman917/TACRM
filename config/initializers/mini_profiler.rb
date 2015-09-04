#if %w(development staging production).include?(Rails.env)
if %w(development staging test production amayra_prod).include?(Rails.env)
  Rack::MiniProfiler.config.pre_authorize_cb = lambda {|env| false } 
end