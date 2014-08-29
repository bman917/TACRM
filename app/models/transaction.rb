class Transaction < ActiveRecord::Base
  belongs_to :air_booking
  belongs_to :client, class_name: 'Profile'
  belongs_to :vendor, class_name: 'Profile'
  belongs_to :agent, class_name: 'Profile'

  delegate :destination_code, :arrival_date, :return_date, to: :air_booking, allow_nil: true

  has_paper_trail :meta => { :profile_id => :clientid, :description => :description}, 
    :ignore => [:updated_at]

  def clientid
    client.id
  end

  def description
    "Transaction '#{name}'"
  end

  def css_id
    "transaction_#{id}"
  end

  def css_id_selector
    "##{css_id}"
  end
end