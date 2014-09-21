require 'spec_helper'

describe Address do
  before(:each) do
    sign_in
  end

  describe "Show Create", js: true do
    before(:each) do
      @p = create(:person)
      visit profile_path(@p)
      click_on 'Client Details'
      click_on 'Add Address'
    end

    it "can close create form" do
      expect(page).to have_css('#new_address_form')
      click_on 'Close'
      sleep 0.25
      expect(page).to have_no_css('#new_address_form')
    end

    it "saves address" do
      expect(find_by_id('address_owner_id', :visible => false).value).to eq @p.id.to_s
      expect(find_by_id('address_owner_type', :visible => false).value).to eq 'Profile'
      fill_in 'Address Line 1', with: 'Rufino Building, Ayala Avenue'
      fill_in 'Address Line 2', with: 'Legaspi Village'
      fill_in 'City', with: 'Makati'
      fill_in 'State region', with: 'Metro Manila'
      fill_in 'Zipcode', with: '12345'
      fill_in 'Description', with: 'Home'
      find(:select, 'address_country').first(:option, 'Philippines').select_option
      click_button 'Save'
      sleep 0.25
      expect(page).to have_content('Rufino Building, Ayala Avenue, Legaspi Village')
      expect(page).to have_content('12345 Metro Manila')
    end
    
    it "performs validation" do
       click_button 'Save'
       expect(page).to have_css('#new_address_form')
    end

  end
end