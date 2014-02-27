class Identification < ActiveRecord::Base
  belongs_to :profile

  scope :passports, -> { where(foid_type: 'Passport')}

  def passport?
  	foid_type == 'Passport'
  end

  def date_issued_f
  	date_issued.to_time.to_s(:long) if date_issued
  end

end
