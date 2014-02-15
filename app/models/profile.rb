class Profile < ActiveRecord::Base
	has_many :phones, as: :contact_detail, :dependent => :delete_all
	has_many :addresses, as: :owner, :dependent => :delete_all
	has_many :notes, :dependent => :delete_all
	has_many :identifications, :dependent => :delete_all
	has_one :account

	def full_name
		if profile_type == 'CORPORATE'
			self.name
		else
			"#{first_name} #{middle_name} #{last_name}"
		end
	end

	def birth_day_med_format 
		birth_day.to_time.to_s(:med) if birth_day
	end
end
