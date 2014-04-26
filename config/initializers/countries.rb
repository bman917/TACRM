# ActionView::Helpers::FormOptionsHelper::COUNTRIES = ["Philippines"]
# ::CountrySelect.use_iso_codes = true

# CountrySelect
module ActionView
  module Helpers
    class FormBuilder
      def country_select(method_name, priority_list = nil, options = {}, html_options = {})

        country = @object.method(method_name).call
        puts "XXXXXXXXXXXXXXXXXXXXXX #{country}. Match #{matched?(country)}"
        options_for_select = all_countries
        if priority_list
          options[:disabled] = "--------------"
          options_for_select = priority_list + ["--------------"] + all_countries
        end

        @template.content_tag :div, class: "#{method_name}_not_found" do
          unless options_for_select.include?(country) || country.nil?
            set_model_attr_to_nil(method_name)
            content = @template.content_tag(:span, country, class: method_name)
            content << @template.content_tag(:span, '(...needs to be updated)', class: 'obsolete_msg')
            content << select(method_name, options_for_select, options, html_options)
          else
            select(method_name, options_for_select, options, html_options)
          end
          
        end
        
      end

      def all_countries
        @all_countries ||= ISO3166::Country.all.map {|c| c[0].titleize}  
      end

      def matched?(country)
        all_countries.include?(country)
      end

      private
      def set_model_attr_to_nil(method_name)
         @object.send(:write_attribute, method_name, nil)
      end
    end
  end
end