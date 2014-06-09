class Address < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  validates :city, presence: {message: "Address must have a city"}

  has_paper_trail :meta => { :profile_id => :prof, :description => :display_short}

  def prof
    self.owner_id
  end

  def line_one_two
    l1 = line_one.try :strip

    if l1 && l1[-1,1] == ','
      l1.chop!
    end

    l2 = line_two.try :strip
    f = l1 if l1
    f = "#{l1}, #{l2}" if l2
    f
  end

  def zip_state_region
    a1 = zipcode.try :strip
    a2 = state_region.try :strip
    result = "-"
    result = a1 if a1
    result += " " + a2 if a2
    result.strip
  end

  def display_short
    "Address - #{self.display.truncate(25)}"
  end

  def display
  	"#{line_one.truncate(15)}, #{city}"
  end
end
