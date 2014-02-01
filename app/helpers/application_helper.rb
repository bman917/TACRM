module ApplicationHelper
	def phone_types
		[
			['Landline','Landline'],
			['Mobile','Mobile'],
			['Unknown','Unknown']
		]
	end

	def section_hide_link(id)
		link_to '-', '', {id: id, class: 'section_hide_link'}
	end	
end
