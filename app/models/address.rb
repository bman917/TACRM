class Address < ActiveRecord::Base
  belongs_to :owner

  def display
  	"#{address_type} - #{line_one}, #{city}, #{state_region}, #{zipcode} #{country}"

  end
end
