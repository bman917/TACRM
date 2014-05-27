class Phone < ActiveRecord::Base
  belongs_to :contact_detail, polymorphic: true
  validates :number, presence: {message: "Phone number must not be blank."}

  scope :for_profiles, -> {where(contact_detail_type: 'Profile')}
  has_paper_trail :meta => { :profile_id => :prof, :description => :display}

  def prof
    self.contact_detail_id
  end

  def display
  	"(#{phone_type})- #{number}"
  end

  
end
