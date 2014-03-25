class ProfileVersion < ActiveRecord::Base
  belongs_to :profile
  belongs_to :version

  def index
  	ProfileVersion.where(profile_id: profile_id).index(self)
  end

  def version
  	PaperTrail::Version.find(version_id)
  end
end
