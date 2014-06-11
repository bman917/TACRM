require 'spec_helper'

describe Group do 
  before(:each) do
    Profile.destroy_all
    
    @p = create(:person)
    @p2 = create(:person, first_name: 'Friend', last_name: 'One')

    sign_in
    visit profiles_path
    view_profile @p
    click_on 'Guests'
  end

  describe 'Add Member', js: true do
    before(:each) do
      click_on 'Add Guest'
    end

    it "opens add member form" do
      expect(page).to have_css('#new_member_form')
    end

    it "has no option to select it's own profile as a member" do
      expect(page.has_select?('member_profile_id', :options => [@p.full_name])).to be false
    end

    it "closes add member form" do
      click_on 'Close'
      sleep 0.25
      expect(page).to have_no_css('#new_member_form')
    end

    it "adds a member and does not include that member on next member selection option" do
      select 'Friend One', from: 'Member'
      fill_in 'Relationship', with: 'Friend'
      click_on 'Save'
      sleep 0.25
      expect(page).to have_content('Friend One')


      click_on 'Add Guest'
      expect(page.has_select?('member_profile_id', :options => [@p2.full_name])).to be false
    end
  end

  describe 'Edit and Delete Member', js: true do
    before(:each) do
      @member = @p.add_member(profile: @p2, relationship: 'Friend')
      
      visit profile_path(@p)
      click_on 'Guests'

      within "tr#member_#{@member.id}" do
        click_on 'Edit'
      end
    end

    it "opens edit form" do
      expect(page).to have_css('#new_member_form') 
      expect(page).to have_content('edit member') 
    end

    it "preselects the member being edited" do
      expect(find(:css, 'select#member_profile_id').value ).to eq(@member.profile.id.to_s)
    end
  end

end