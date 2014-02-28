class Identification < ActiveRecord::Base
  belongs_to :profile

  scope :passports, -> { where(foid_type: 'Passport')}
  scope :visas, -> { where(foid_type: 'Visa')}

  def passport?
  	foid_type == 'Passport'
  end

  def date_issued_f
  	date_issued.to_time.to_s(:long) if date_issued
  end

  def visa_type
  	self.sub_type
  end

  def visa_type=(t)
  	self.sub_type = t
  end
end
