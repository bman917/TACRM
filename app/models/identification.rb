class Identification < ActiveRecord::Base
  belongs_to :profile

  validates_presence_of :profile_id, :foid, :foid_type
  validate :profile_not_locked
  before_destroy :profile_not_locked

  scope :passports, -> { where(foid_type: 'Passport')}
  scope :visas, -> { where(foid_type: 'Visa')}
  scope :other, -> { where.not(foid_type: ['Visa','Passport'])}

  has_paper_trail :meta => { :profile_id => :prof, :description => :display}

  mount_uploader :doc_image, DocImageUploader

  def profile_not_locked
    if profile.try :locked?
      errors.add(:profile, "is locked. Unlock profile before editing this document.")
      return false
    end
  end

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

  def other?
    foid_type == 'Other'
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
