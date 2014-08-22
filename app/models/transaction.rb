class Transaction < ActiveRecord::Base
  belongs_to :air_booking
  belongs_to :client, class_name: 'Profile'
  belongs_to :vendor, class_name: 'Profile'
  belongs_to :agent, class_name: 'Profile'

  delegate :destination_code, :arrival_date, :return_date, to: :air_booking, allow_nil: true

end
