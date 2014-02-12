class Phone < ActiveRecord::Base
  belongs_to :contact_detail

  def display
  	"#{phone_type} - #{number}"
  end
end
