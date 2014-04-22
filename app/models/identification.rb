class Identification < ActiveRecord::Base
  belongs_to :profile

  scope :passports, -> { where(foid_type: 'Passport')}
  scope :visas, -> { where(foid_type: 'Visa')}
  scope :other, -> { where.not(foid_type: ['Visa','Passport'])}

  has_paper_trail :meta => { :profile_id => :prof, :description => :display}

  def css_id
    "identification_#{id}"
  end

  def prof
    self.profile_id
  end

  def display
    "Passport #{foid}" if passport?
    "#{country} (#{visa_type} Visa) #{foid}" if visa?
    "#{foid_type} - #{foid}"
  end

  def visa?
    foid_type == 'Visa'
  end
  
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
