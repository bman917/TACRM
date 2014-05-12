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

  scope :person, -> {where(profile_type: ['INDIVIDUAL','AGENT','GUEST'])}
  scope :search_by_name, -> (term) { 
    where("first_name like ? or middle_name like ? or last_name like ?",
      "%#{term}%", "%#{term}%", "%#{term}%").order(:first_name)} 


    has_paper_trail :meta => { :profile_id => :prof, :description => :display}

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
    profile_type.upcase == 'AGENT'
  end

  def individual_client?
    profile_type.upcase == 'INDIVIDUAL'
  end

  def corporate_client?
    profile_type.upcase == 'CORPORATE'
  end

  def guest
    guest_client?
  end

  def guest_client?
    profile_type.upcase == 'GUEST'
  end

  def vendor?
    profile_type.upcase == 'VENDOR'
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
end
