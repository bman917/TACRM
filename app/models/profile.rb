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
  #validates_uniqueness_of :first_name, scope: [:last_name, :middle_name, :birth_day], case_sensitive: false, if: :person?
  #validates_uniqueness_of :name, scope: [:business_type], case_sensitive: false, if: :corporate_client?
  validates_with NameValidator, on: :create

  scope :all_undeleted, -> {where(deleted: [nil, false]).includes(:phones, :addresses)}
  scope :no_contact_detail, -> {all_undeleted.where("id not in (select contact_detail_id from phones where contact_detail_type = \"Profile\")")}
  scope :no_address, -> {all_undeleted.where("id not in (select owner_id from addresses where owner_type = \"Profile\")")}
  scope :person, -> {all_undeleted.where(profile_type: ['INDIVIDUAL','AGENT','GUEST'])}
  scope :vendors, -> {all_undeleted.where(profile_type: 'VENDOR')}
  scope :agents, -> {all_undeleted.where(profile_type: 'AGENT')}
  scope :search_by_full_name, -> (term) { 
    all_undeleted.where("first_name like ? or middle_name like ? or last_name like ? or name like ?",
      "%#{term}%", "%#{term}%", "%#{term}%", "%#{term}%").order(:first_name)} 

  scope :search_by_name, -> (term) { 
    all_undeleted.where("first_name like ? or middle_name like ? or last_name like ?",
      "%#{term}%", "%#{term}%", "%#{term}%").order(:first_name)} 

  has_paper_trail :meta => { :profile_id => :prof, :description => :display}, 
    :ignore => [:updated_at]

  scope :deleted, -> {where(deleted: true)}

  before_validation :truncate_values

  def self.apply_filter(params={})
      @profile_type = params[:profile_type] || 'ALL'
      @profile_type.upcase!

      case @profile_type
      when 'ALL'
        @profiles = Profile.all_undeleted
      when 'NO_CONACT_DETAILS'
        @profiles = Profile.all_undeleted.no_contact_detail
      when 'NO_ADDRESS'
        @profiles = Profile.all_undeleted.no_address
      else
        @profiles = Profile.all_undeleted.where(profile_type: @profile_type)
      end
      @profiles
  end

  def truncate_values
    first_name.try(:squish!)
    middle_name.try(:squish!)
    last_name.try(:squish!)
    name.try(:squish!)
    # puts "#{name} #{first_name} #{middle_name} #{last_name} #{birth_day}"
  end

  def restore
    self.deleted = false
    self.locked = false
    self.save
  end

  def delete
    self.deleted = true
    self.locked = true
    self.save
  end

  def not_deleted?
    !deleted?
  end

  def deleted?
    self.deleted
  end

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
      locked == false && not_deleted?
    end

    def locked?
      locked == true || deleted?
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

  def non_members(params={})
    included_profile_ids = params[:included_profile_ids]

    wrong_ids = default_group.members.pluck(:profile_id)
    wrong_ids << self.id

    filtered_array = if included_profile_ids 
      wrong_ids.reject { |id| included_profile_ids.include? id }
    else
      wrong_ids
    end

    Profile.where(profile_type: 'INDIVIDUAL').where.not(id: filtered_array).order(first_name: :asc)
  end

  def occupation_posistion
    s = "#{self.occupation} / #{self.job_position}".strip
    s.chop! if s.ends_with?("/")
    s = s[1..-1] if s.starts_with?("/")
    s
  end

  def to_s
    self.full_name
  end
end
