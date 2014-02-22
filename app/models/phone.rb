class Phone < ActiveRecord::Base
  belongs_to :contact_detail
  validates :number, presence: {message: "Phone number must not be blank."}

  def display
  	"#{phone_type} - #{number}"
  end
end
