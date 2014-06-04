class Note < ActiveRecord::Base
  belongs_to :profile
  validates :note, presence: {message: "Note must not be blank."}
  
  has_paper_trail :meta => { :profile_id => :prof, :description => :display}

  def prof
    self.profile_id
  end

  def display
    "Note - #{self.note.truncate(25)}"
  end

end
