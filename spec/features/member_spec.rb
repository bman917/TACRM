require 'spec_helper'

describe 'Guest' do 
  before(:each) do
    Profile.destroy_all
    
    @p = create(:person, first_name: "Juan", last_name: "Dela Cruz")
    @p2 = create(:person, first_name: 'Friend', last_name: 'One')

    sign_in
    visit profiles_path
    view_profile @p
    click_on 'Guests'
  end

  describe 'Add via remote form', js: true do
    before(:each) do
      click_on 'Add Guest'
    end

    it "can open the form" do
      expect(page).to have_css('#new_member_form')
    end

    it "can close the form" do
      click_on 'Close'
      sleep 0.25
      expect(page).to have_no_css('#new_member_form')
    end

    it "does not allow to add the profile as it's own guest" do
      fill_autocomplete 'profile_full_name', with: 'Juan Dela Cru', not_found: true
    end

    it "can add a guest and thes now duplicate guests to be added", js: true do
      fill_autocomplete 'profile_full_name', with: 'Fr'
      fill_in 'Relationship', with: 'Friend'
      click_on 'Save'
      sleep 0.25
      expect(page).to have_content('Friend One')

      click_on 'Add Guest'
      fill_autocomplete 'profile_full_name', with: 'Fr', not_found: true
    end
  end

  describe 'Operations on Existing Guests', js: true do
    before(:each) do
      @member = @p.add_member(profile: @p2, relationship: 'Friend')
      visit profile_path(@p)
      click_on 'Guests'
    end

    describe 'Edit' do
      before(:each) do
        within "tr#member_#{@member.id}" do
          click_on 'Edit'
        end
      end
      it "opens edit form" do
        expect(page).to have_css('#new_member_form') 
        expect(page).to have_content('edit member') 
      end

      it "preselects the Guest being edited" do
        expect(find_by_id('member_profile_id', :visible => false).value).to eq(@member.profile.id.to_s)
      end

      it "can save edits" do
         fill_in 'Relationship', with: 'Best Friend'
         click_on 'Save'
         expect(page).to have_content('Best Friend')
      end
    end

    describe 'Delete' do
      it "can delete a guest" do
        within "tr#member_#{@member.id}" do
          click_on 'Delete'
          page.driver.browser.switch_to.alert.accept
        end
        page.assert_no_selector("tr#member_#{@member.id}")
      end
    end
    
  end
end