require 'spec_helper'

describe "Transaction" do
  before(:each) do
    sign_in
  end

  describe "Domestic Ticketing", js: true do

    it "can be created" do
      client = create(:person)
      vendor = create(:vendor, name: "Lucky Travel Corp")
      agent = create(:agent)
      
      visit portal_index_path

      click_on "New Transaction"

      expect(page).to have_css("#new_transaction_form")
      
      fill_autocomplete 'profile_full_name', with: client.first_name

      select 'Domestic Ticketing', from: 'transaction_type_code'
      select 'Cebu', from: 'transaction_destination_code'

      fill_in 'Transaction Name', with: 'Cebu Trip'

      select "2013", from: 'transaction_arrival_date_1i'
      select "May", from: 'transaction_arrival_date_2i'
      select "19", from: 'transaction_arrival_date_3i'

      select "2013", from: 'transaction_return_date_1i'
      select "Aug", from: 'transaction_return_date_2i'
      select "19", from: 'transaction_return_date_3i'

      select 'Confirmed', from: 'Status'

      fill_in 'PNR', with: 'ABC123'

      select vendor.full_name, from: 'Vendor'
      select agent.full_name, from: 'Agent'

      click_on 'Save'

      expect(current_path).to eq profile_path(client)

      within("#content") do
        expect(page).to have_content("Transactions")
        expect(page).to have_content("Cebu Trip")
        expect(page).to have_content("CEB")
      end
    end
  end
end