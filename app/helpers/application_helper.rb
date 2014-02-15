module ApplicationHelper

	def profile_types
		[
			['INDIVIDUAL','INDIVIDUAL'],
			['GUEST','GUEST'],
			['CORPORATE','CORPORATE']

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
			['Unknown','Unknown']
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
end
