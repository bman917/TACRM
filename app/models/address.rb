class Address < ActiveRecord::Base
  belongs_to :owner
  validates :city, presence: {message: "Address must have a city"}

  has_paper_trail :meta => { :profile_id => :prof, :description => :display_short}

  def prof
    self.owner_id
  end

  def display_short
    "Address - #{self.display.truncate(25)}"
  end

  def display
  	"#{line_one.truncate(15)}, #{city}"
  end
end
