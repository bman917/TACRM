require 'spec_helper'

describe "Transaction" do

  before(:each) do
    @client = create(:person)
    @vendor = create(:vendor)
    @agent = create(:agent)
    sign_in
  end

  describe "Add link on Profile Show Page", :js, :add_link do
    it "does not have a link for corporate profiles" do
      check_add_link create(:company)
    end
    it "does not have a link for agent profiles" do
      check_add_link create(:agent)
    end
    it "does not have a link for agent profiles" do
      check_add_link create(:vendor)
    end
  end

  describe "Associations", :js, :associations do
    it "is shown betwwen Individual and Corporations" do
      t1 = create(:transaction)
      t2 = create(:transaction)

      t1_row_selector = "tr#transaction_#{t1.id}"
      t2_row_selector = "tr#transaction_#{t2.id}"

      corp = create(:company)
      corp.add_member(profile: t1.client, relationship: 'Employee')
      corp.add_member(profile: t2.client, relationship: 'Employee')

      visit profile_path(corp)
      click_on_transactions_tab
      expect(page).to have_selector(t1_row_selector)
      expect(page).to have_selector(t2_row_selector)
      within(t1_row_selector) { expect(page).to have_content(t1.client.full_name) }
      within(t2_row_selector) { expect(page).to have_content(t2.client.full_name) }

    end

    it "is shown between Individual, Vendor and Agent" do
      t = create(:transaction)
      transaction_row_selector = "tr#transaction_#{t.id}"

      visit profile_path(t.vendor)
      click_on_transactions_tab
      expect(page).to have_selector(transaction_row_selector)
      within(transaction_row_selector) do
        expect(page).to have_content(t.client.full_name)
      end

      visit profile_path(t.agent)
      click_on_transactions_tab
      expect(page).to have_selector(transaction_row_selector)
      within(transaction_row_selector) do
        expect(page).to have_content(t.client.full_name)
      end

    end
  end

  describe "Domestic Ticketing", :js do

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

      click_on_transactions_tab
      within("#transactions_all") { click_on "Add New" }

      fill_in_and_save_domestic_ticketing_form do
        within("#new_transaction_form") { expect(page).to have_content(/#{p.full_name}/i) }
      end

      within("#transactions_all") do
        expect(page).to have_content("Cebu Trip")
        expect(page).to have_content("CEB")
      end
    end

    it "can be deleted by admin", :delete do
      t = create(:transaction)
      transaction_row_selector = "tr#transaction_#{t.id}"

      visit profile_path(t.client)
      click_on_transactions_tab
      within(transaction_row_selector) do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
      end
      expect(page).to have_no_selector(transaction_row_selector)
    end

    it "cannot be deleted by moderator", :delete do
      click_on 'Logout'
      sign_in_as role: :moderator
      t = create(:transaction)
      transaction_row_selector = "tr#transaction_#{t.id}"

      visit profile_path(t.client)
      click_on_transactions_tab
      expect(page).to have_no_selector("a#delete_#{t.id}") 
    end

    it "can be edited", :edit do
      t = create(:transaction)
      transaction_row_selector = "tr#transaction_#{t.id}"

      visit profile_path(t.client)
      click_on_transactions_tab
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

def check_add_link(profile)
  visit profile_path(profile)
  click_on_transactions_tab
  within(".transactions") do 
    expect(page).to have_no_link("Add New")
  end
end

def click_on_transactions_tab
  within("#content") do 
   click_on 'Transactions' 
   sleep 0.5
 end
end

def fill_in_and_save_domestic_ticketing_form

  expect(page).to have_css("#new_transaction_form")

  yield if block_given?

  select 'Domestic Ticketing', from: 'transaction_type_code'
  select 'Cebu', from: 'transaction_destination_code'

  fill_in 'Name', with: 'Cebu Trip'

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