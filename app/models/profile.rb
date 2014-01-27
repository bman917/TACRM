class Profile < ActiveRecord::Base
	has_many :phones, as: :contact_detail, :dependent => :delete_all
	has_many :addresses, as: :owner, :dependent => :delete_all

	def full_name
		"#{first_name} #{middle_name} #{last_name}"
	end
end
