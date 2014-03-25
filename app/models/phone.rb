class Phone < ActiveRecord::Base
  belongs_to :contact_detail
  validates :number, presence: {message: "Phone number must not be blank."}

  has_paper_trail

  after_save :update_trail
  after_destroy :update_trail

  def update_trail
  	ProfileVersion.create(profile_id: contact_detail_id, version_id: versions.last.id)
  end

  def display
  	"#{phone_type} - #{number}"
  end
end
