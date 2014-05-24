require 'spec_helper'

describe Profile do
  before(:each) do
    sign_in
  end

  describe "Profile Index Filters" do
    it "preselects according to the profile type filter" do 
      click_on 'Agents'
      expect(find(:css, 'select#profile_type').value).to eq 'AGENT'
      click_on 'Vendor'
      expect(find(:css, 'select#profile_type').value).to eq 'VENDOR'
    end
  end

  describe "Create", js: true do

    it "can open and close a form" do
      click_on 'ADD INDIVIDUAL'
      expect(page).to have_css('#new_profile_form')

      click_link 'Close'
      sleep 0.25
      expect(page).to have_no_css('#new_profile_form')   
    end

    it "can create a profile for an INDIVIDUAL" do

      click_on 'ADD INDIVIDUAL'

      fill_in 'First name',  with: "Bart"
      fill_in 'Middle name', with: "C"
      fill_in 'Last name',   with: "Olome"

      select "2013", from: 'profile_birth_day_1i'
      select "May", from: 'profile_birth_day_2i'
      select "19", from: 'profile_birth_day_3i'
      
      fill_in 'Email', with: 'Bart.Olome@yahoo.com'

      select "2014", from: 'profile_client_since_1i'
      select "Jan", from:  'profile_client_since_2i'
      select "1", from:   'profile_client_since_3i'

      click_button 'Save'

      saved_bart = Profile.find_by_first_name('Bart')

      expect(saved_bart).to be_truthy
      expect(current_path).to eq profile_path(saved_bart)

      expect(saved_bart.middle_name).to eq "C"
      expect(saved_bart.last_name).to   eq "Olome"
      expect(saved_bart.email).to       eq "Bart.Olome@yahoo.com"

      expect(saved_bart.birth_day).to    eq Date.parse("May 19, 2013")
      expect(saved_bart.client_since).to eq Date.parse("Jan  1, 2014")

      assert saved_bart.individual_client?
    end

    it "can create a profile for an VENDOR", js: true do

      click_on 'ADD VENDOR'

      fill_in 'Vendor Name'   , with: 'Datalex'
      fill_in 'Business type' , with: 'Travel'
      fill_in 'Email'         , with: 'sales@datalex.com'
      fill_in 'Contact person', with: 'Jacky'
      fill_in 'Credit limit'  , with: '100000'

      click_button 'Save'

      saved_p = Profile.find_by_name('Datalex')

      expect(saved_p).to be_truthy
      expect(current_path).to eq profile_path(saved_p)

      assert saved_p.vendor?
    end
  end

  describe "Lock", js: true do 
    it "can be locked" do
      p = create(:person, first_name: 'Lock', last_name: 'Test')
      visit profiles_path
      within("tr#profile_#{p.id}") do
        click_on 'Lock Profile'
        alert = page.driver.browser.switch_to.alert
        alert.accept
      end
      expect(page).to have_css("#p#{p.id}_locked")
    end
  end
end