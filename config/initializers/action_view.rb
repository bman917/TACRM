module ActionView
	module Helpers
		module UrlHelper

			alias_method :original_link_to, :link_to

			#
			#overrite link_to and incorporate cancan auth checks
			#
			def link_to(name = nil, options = nil, html_options = nil, &block)
				method = html_options[:method] if html_options
				# puts "Name: #{name}, Action View Override - Method: '#{method}', Options:#{options}"
				if options.class == String || method == "" || method == nil || can?(method, options)
					original_link_to(name, options, html_options, &block) 
				end

			end
		end
	end
end