require 'spec_helper'

describe "Transaction" do

  before(:each) do
    @client = create(:person)
    @vendor = create(:vendor)
    @agent = create(:agent)
  end

  describe "Domestic Ticketing", :js do
    before(:each) do
      sign_in
    end

    it "can be created a-la-carte" do

      visit portal_index_path

      click_on "New Transaction"

      fill_in_and_save_domestic_ticketing_form do 
        fill_autocomplete 'profile_full_name', with: @client.full_name
      end

      expect(current_path).to eq profile_path(@client)

      within("#content") do
        expect(page).to have_content("Transactions")
        expect(page).to have_content("Cebu Trip")
        expect(page).to have_content("CEB")
      end
    end

    it "can be created in profile show page", :show do
      p = create(:person)
      visit profile_path(p)

      click_on_cransaction_tab
      within("#transactions_all") { click_on "Add New" }

      fill_in_and_save_domestic_ticketing_form do
        within("#new_transaction_form") { expect(page).to have_content(p.full_name) }
      end


      within("#transactions_all") do
        expect(page).to have_content("Cebu Trip")
        expect(page).to have_content("CEB")
      end
    end

    it "can be deleted", :delete do
      t = create(:transaction)
      transaction_row_selector = "tr#transaction_#{t.id}"

      visit profile_path(t.client)
      click_on_cransaction_tab
      within(transaction_row_selector) do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
      end
      expect(page).to have_no_selector(transaction_row_selector)
    end

    it "can be edited", :edit do
      t = create(:transaction)
      transaction_row_selector = "tr#transaction_#{t.id}"

      visit profile_path(t.client)
      click_on_cransaction_tab
      within(transaction_row_selector) do
        click_on 'Edit'
      end
      expect(page).to have_css("#new_transaction_form")
      within("#new_transaction_form") do
        expect(page).to have_content("edit transaction")
        fill_in "PNR", with: "PNR is Edited"
        click_on 'Save'
      end

      within("#transactions_all") do
        expect(page).to have_content("PNR is Edited")
      end
    end
  end
end

def click_on_cransaction_tab
  within("#content") { click_on 'Transactions' }
end

def fill_in_and_save_domestic_ticketing_form

  expect(page).to have_css("#new_transaction_form")

  yield if block_given?

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

  select @vendor.full_name, from: 'Vendor'
  select @agent.full_name, from: 'Agent'

  click_on 'Save'
end