require 'spec_helper'

describe Phone do
  before(:each) do
    sign_in
  end

  describe "Show Create", js: true do
    before(:each) do
      @p = create(:person)
      visit profile_path(@p)
      click_on 'Client Details'
      click_on 'Add Phone Number'
    end

    it "close create form" do
      expect(page).to have_css('#new_phone_form')
      click_on 'Close'
      expect(page).to have_no_css('#new_phone_form')
    end

    it "saves phone number" do
      expect(page).to have_css('#new_phone_form')
      expect(find_by_id('phone_contact_detail_id', :visible => false).value).to eq @p.id.to_s
      expect(find_by_id('phone_contact_detail_type', :visible => false).value).to eq 'Profile'

      select 'Landline', from: 'phone_phone_type'
      fill_in 'phone_number', with: '111222333444'
      fill_in 'Description', with: 'Created on show create'
      click_button 'Save'
      sleep 0.25
      expect(page).to have_content('11122-233-3444')
      expect(page).to have_content('Created on show create')
    end
  end

  describe "Edit and Delete", js: true do
    before(:each) do
      @p = create(:person)
      @p.phones.create(phone_type:'Landline', number: '7777777')
      @phone_css = "tr#profile_phone_#{@p.phones.first.id}"
      visit profile_path(@p)
      click_on 'Client Details'
    end

    it "Opens Edit Form" do
      within(@phone_css) do
        click_on 'Edit'
      end

      expect(page).to have_css('#new_phone_form')
    end

  end

  describe "Index Create", js: true do
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
      fill_in 'Description', with: 'Main contact'
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

  describe 'Locked Profile', js: true do
    it "has no add link if Profile is locked" do
      Profile.destroy_all
      @p = create(:person, first_name: 'Incomplete', last_name: 'Contact Details', locked: true)
      visit profiles_path

      within("tr#profile_#{@p.id}") do
        assert has_no_link?('Add Phone')
      end

      view_profile(@p)
      click_on 'Client Details'
      assert has_no_link?('Add Phone Number')
    end
  end
end