class Address < ActiveRecord::Base
  belongs_to :owner
  validates :city, presence: {message: "Address must have a city"}

  def display
  	"#{address_type} - #{line_one}, #{city}, #{state_region}, #{zipcode} #{country}"

  end
end
