require 'spec_helper'

describe "Profiles" do
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

  describe "Profile Create" do
    it "can create a profile for an INDIVIDUAL", js: true do

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
end