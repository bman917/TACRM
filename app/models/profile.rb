class Profile < ActiveRecord::Base
	has_many :phones, as: :contact_detail, :dependent => :delete_all
end
