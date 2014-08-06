require 'spec_helper'

describe Profile do
  before(:each) do
    sign_in
    visit profiles_path
  end

  describe "Filters" do
    it "preselects according to the profile type filter" do 
      click_on 'Agents'
      expect(find(:css, 'select#profile_type').value).to eq 'AGENT'
      click_on 'Vendor'
      expect(find(:css, 'select#profile_type').value).to eq 'VENDOR'
      click_on 'No Contact Details'
      expect(find(:css, 'select#profile_type').value).to eq 'NO_CONACT_DETAILS'
      click_on 'No Address'
      expect(find(:css, 'select#profile_type').value).to eq 'NO_ADDRESS'
    end

    it "can select profiles with incomplete contact details", js: true do
      p = create(:person, first_name: 'Incomplete', last_name: 'Contact Details')
      sleep 0.25
      select 'No Contact Details'
      sleep 0.25
      expect(page).to have_content('Incomplete')
    end

    it "can select profile with no address", js: true do
      p = create(:person, first_name: 'Firstname No Address', last_name: 'Person')
      sleep 0.25
      select 'No Address'
      sleep 0.25
      expect(page).to have_content('Firstname No Address')
    end
  end

  # describe "Edit", js: true do
  #   it "can edit a profile of an INDIVIDUAL" do
  #     p = create(:person)
  #   end
  # end
  describe "Delete", :js, :delete  do
    before(:each) do 
      Profile.delete_all
      @p = create(:person)
      visit profiles_path
    end

    it "can delete a profile" do
      within("tr#profile_#{@p.id}") do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
      end
      expect(page).to have_no_selector("tr#profile_#{@p.id}")
    end

    describe "Restore" do
      before(:each) do 
        @p.delete
        visit view_deleted_profiles_path
      end

      it "can view deleted profiles" do
        expect(page).to have_selector("tr#profile_#{@p.id}")
        expect(page).to have_no_selector("a#p#{@p.id}_locked")
      end

      it "can restore a deleted profile" do
        within("tr#profile_#{@p.id}") do
          click_on 'Restore'
          page.driver.browser.switch_to.alert.accept
        end
        expect(page).to have_content("has been restored")
        expect(page).to have_no_selector("tr#profile_#{@p.id}")
      end
     end
  end


  describe "Create", :js, :create do

    it "can open and close a form" do
      click_on 'ADD INDIVIDUAL'
      expect(page).to have_css('#new_profile_form')

      click_link 'Close'
      sleep 0.5
      expect(page).to have_no_css('#new_profile_form')   
    end

    it "can create a profile for an INDIVIDUAL" do

      click_on 'ADD INDIVIDUAL'

      select "Mr.", from: 'Title'
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
      expect(saved_bart.title).to       eq "Mr."

      expect(saved_bart.birth_day).to    eq Date.parse("May 19, 2013")
      expect(saved_bart.client_since).to eq Date.parse("Jan  1, 2014")

      assert saved_bart.individual_client?
    end

    it "displays error on duplicate records", js: true do
      existing_profile = create(:person)

      click_on 'ADD INDIVIDUAL'
      fill_in 'First name',  with: existing_profile.first_name
      fill_in 'Middle name', with: existing_profile.middle_name
      fill_in 'Last name',   with: existing_profile.last_name

      click_button 'Save'
      expect(page).to have_content("Name '#{existing_profile.full_name}' has already been taken")

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

    it "can be locked and unlocked on Index page" do
      p = create(:person, first_name: 'Lock', last_name: 'Test')
      visit profiles_path
      sleep 0.25
      within("tr#profile_#{p.id}") do
        click_on 'Lock Profile'
        alert = page.driver.browser.switch_to.alert
        alert.accept
      end
      expect(page).to have_css("#p#{p.id}_locked")

      within("tr#profile_#{p.id}") do
        click_on 'Unlock Profile'
        alert = page.driver.browser.switch_to.alert
        alert.accept
      end
      expect(page).to have_css("#p#{p.id}_unlocked")
    end

    it "can be locked on Show Page" do
      p = create(:person, first_name: 'Show', last_name: 'Lock')
      visit profile_path(p)
      expect(current_path).to eq profile_path(p)
      click_on 'Lock Profile'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_css("#p#{p.id}_locked") 

      click_on 'Unlock Profile'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_css("#p#{p.id}_unlocked") 
    end
  end

  describe "Show", :js, :show do
    it "displays correct details" do
      p = create(:person, title: 'Mayor')
      visit profile_path(p)
      expect(page).to have_content('Mayor')
    end
  end
end