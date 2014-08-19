require 'spec_helper'

describe "Transaction" do
  before(:each) do
    sign_in
  end

  describe "Domestic Ticketing" do

    it "can be created" do
      
      visit portal_index_path

      click_on "New Transaction"
      
      fill_autocomplete 'transaction_client_full_name', with: 'Juan'

      fill_in 'Transaction Name', with: 'Japan Trip'

      select 'Domestic Ticketing', from: 'transaction_type'

      select "2013", from: 'air_booking_arrival_date_1i'
      select "May", from: 'air_booking_arrival_date_2i'
      select "19", from: 'air_booking_arrival_date_3i'

      select "2013", from: 'air_booking_return_date_1i'
      select "Aug", from: 'air_booking_return_date_2i'
      select "19", from: 'air_booking_return_date_3i'

      select 'Confirmed', from: 'air_booking_status'

      fill_in 'PNR/Ticket No.', with: 'ABC123'

      select 'Lucky Travel Corp', from: 'air_booking_supplier'
      select 'Agent X44', from: 'air_booking_supplier'
    end
  end
end