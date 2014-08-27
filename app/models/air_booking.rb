class AirBooking < ActiveRecord::Base
  has_one :transaction

  has_paper_trail :meta => { :profile_id => :clientid, :description => :description}, 
    :ignore => [:updated_at]

  def clientid
    Transaction.find_by_air_booking_id(id).try :clientid
  end

  def description
    "Air Booking - #{destination_code} #{arrival_date.try(:to_date).try(:to_s, :short)}-#{return_date.try(:to_date).try(:to_s, :short)}"
  end
end
