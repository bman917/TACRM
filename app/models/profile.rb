class Profile < ActiveRecord::Base
  attr_reader :label, :value

  has_many :phones, as: :contact_detail, :dependent => :delete_all
  has_many :addresses, as: :owner, :dependent => :delete_all
  has_many :notes, :dependent => :delete_all
  has_many :identifications, :dependent => :delete_all
  has_one :account, autosave: true
  has_many :profile_versions, class_name: "PaperTrail::Version", foreign_key: "profile_id"

  validates :first_name, presence: {message: "First name must not be blank."}, if: :person?
  validates :last_name, presence: {message: "Last name must not be blank."}, if: :person?
  validates :name, presence: {message: "Company name must not be blank."}, if: :corporate_client?
  before_destroy :profile_not_locked

  scope :no_contact_detail, -> {where("id not in (select contact_detail_id from phones where contact_detail_type = \"Profile\")")}
  scope :no_address, -> {where("id not in (select owner_id from addresses where owner_type = \"Profile\")")}
  scope :person, -> {where(profile_type: ['INDIVIDUAL','AGENT','GUEST'])}
  scope :search_by_name, -> (term) { 
    where("first_name like ? or middle_name like ? or last_name like ?",
      "%#{term}%", "%#{term}%", "%#{term}%").order(:first_name)} 


  has_paper_trail :meta => { :profile_id => :prof, :description => :display}, 
    :ignore => [:updated_at]

  def profile_not_locked
    if locked?
      errors.add(:profile, "is locked. Unlock profile before editing.")
      return false
    end
  end

    def lock_status
      if locked?
        'LOCKED'
      else
        'UNLOCKED'
      end
    end

    def unlocked?
      locked == false
    end

    def locked?
      locked == true
    end

    def value
      id
    end
    
    def label
      full_name
    end

    def person?
      individual_client? || guest_client? || agent?
    end

  def prof
    self.id
  end

  def display
    "Client Details - #{full_name}"
  end

  def agent?
    profile_type.try(:upcase) == 'AGENT'
  end

  def individual_client?
    profile_type.try(:upcase) == 'INDIVIDUAL'
  end

  def corporate_client?
    profile_type.try(:upcase) == 'CORPORATE'
  end

  def guest
    guest_client?
  end

  def guest_client?
    profile_type.try(:upcase) == 'GUEST'
  end

  def vendor?
    profile_type.try(:upcase) == 'VENDOR'
  end

  def full_name
    if person?
      "#{first_name} #{middle_name} #{last_name}".strip
    else
      self.name
    end
  end

  def birth_day_med_format 
    birth_day.to_time.to_s(:med) if birth_day
  end

  def cache_key
    "#{super}/-versions-#{profile_versions.count}"
  end

  def contact_details_cache_key
    p_count = phones.count
    p_max_updated_at =  phones.maximum(:updated_at).try(:utc).try(:to_s, :number)
    a_count = addresses.count
    a_max_updated_at = addresses.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{cache_key}-phones/#{p_count}-#{p_max_updated_at}-addresses/#{a_count}-#{a_max_updated_at}"
  end

  def documents_cache_key
    "#{cache_key}/identifications/#{generic_cache_key(identifications)}"
  end

  def updates_liquid_slider_panel_number

    if vendor? 
      3
    elsif person? && account != nil
    5
    else
        4 
    end

  end

  def default_group
    if account.groups.count == 0
      account.groups.create(name: 'Default Group')
    else
      account.groups.first
    end
  end

  def add_member(member_attributes)
    default_group.members.create(member_attributes)    
  end

  def remove_member(profile)
    default_group.members.where(profile: profile).first.try :destroy
  end

  def members
    default_group.members
  end

  def non_members
    wrong_ids = default_group.members.pluck(:profile_id)
    wrong_ids << self.id
    Profile.where(profile_type: 'INDIVIDUAL').where.not(id: wrong_ids)
  end
end
