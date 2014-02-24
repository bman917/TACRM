class Profile < ActiveRecord::Base
	has_many :phones, as: :contact_detail, :dependent => :delete_all
	has_many :addresses, as: :owner, :dependent => :delete_all
	has_many :notes, :dependent => :delete_all
	has_many :identifications, :dependent => :delete_all
	has_one :account

	validates :first_name, presence: {message: "First name must not be blank."}, unless: :corporate_client?
	validates :last_name, presence: {message: "Last name must not be blank."}, unless: :corporate_client?
	validates :name, presence: {message: "Company name must not be blank."}, if: :corporate_client?

	def corporate_client?
		profile_type == 'CORPORATE'
	end

	def full_name
		if corporate_client?
			self.name
		else
			"#{first_name} #{middle_name} #{last_name}"
		end
	end

	def birth_day_med_format 
		birth_day.to_time.to_s(:med) if birth_day
	end
end
