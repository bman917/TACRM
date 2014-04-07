module ApplicationHelper

	def version
		'version: 1.0.1'
	end

	def add_role(key)
		"#{current_user.role}-#{key}"
	end

	def main_country_list
		["Philippines","Japan", "Korea", "Singapore", "Thailand", "United States"]
	end

	def gender_types
		[
			['Male','Male'],
			['Female','Female']
		]
	end

	def marital_status_types
		[
			['Single','Single'],
			['Married','Married']

		]
	end

	def profile_types
		[
			['INDIVIDUAL','INDIVIDUAL'],
			['GUEST','GUEST'],
			['CORPORATE','CORPORATE'],
			['AGENT','AGENT']

		]
	end

	def foid_types
		[
			['Drivers License', 'Drivers License'],
			['Passport','Passport'],
			['Company ID', 'Company ID'],
			['SSS ID', 'SSS ID']
		]
	end
	def phone_types
		[
			['Landline','Landline'],
			['Mobile','Mobile'],
			['Fax','Fax']
		]
	end

	def section_hide_link(id)
		link_to '+', '', {id: id, class: 'section_hide_link'}
	end	

	def profile_selector(f)
		f.collection_select :profile_id, Profile.where(profile_type: 'INDIVIDUAL'), :id, :full_name, {}, class: 'focus_on_toggle'
	end

	def add_link(params={text: 'Add', id: 'add_link'})
		link_to params[:text], '', id: params[:id], class: "add_fields no-print"
	end

	def format_date(date)
		date.to_time.to_s(:med)
	end
end
