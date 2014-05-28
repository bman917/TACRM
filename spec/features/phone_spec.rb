require 'spec_helper'

describe Phone do
  before(:each) do
    sign_in
  end

  describe "Create", js: true do
    before(:each) do
      @p = create(:person, first_name: 'Incomplete', last_name: 'Contact Details')
      visit profiles_path
      within("tr#profile_#{@p.id}") do
        click_on 'Add Phone'
      end
    end

    after(:each) do
      Profile.destroy_all
    end

    it "opens create form" do
      click_on 'Close'
    end

    it "saves phone number" do
      
      expect(page).to have_css('#new_phone_form')
      expect(find_by_id('phone_contact_detail_id', :visible => false).value).to eq @p.id.to_s
      expect(find_by_id('phone_contact_detail_type', :visible => false).value).to eq 'Profile'

      select 'Landline', from: 'phone_phone_type'
      fill_in 'phone_number', with: '1234567'
      click_button 'Save'

      within("tr#profile_#{@p.id}") do
        expect(page).to have_content('1234567')
      end
    end

    it "validates empty phone number" do
       select 'Landline', from: 'phone_phone_type'
       click_button 'Save'
       expect(page).to have_css('#new_phone_form')
    end
  end

  describe 'Locked Profile' do
    it "has no add link if Profile is locked" do
      Profile.destroy_all
      @p = create(:person, first_name: 'Incomplete', last_name: 'Contact Details', locked: true)
      visit profiles_path

      within("tr#profile_#{@p.id}") do
        assert has_no_link?('Add Phone')
      end
    end
  end
end