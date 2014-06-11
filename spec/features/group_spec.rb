require 'spec_helper'

describe Group do 
  before(:each) do
    Profile.destroy_all
    @p = create(:person)
    sign_in
    visit profiles_path
  end

  describe 'Member', js: true do
    it "opens add member form" do
      view_profile @p
      click_on 'Guests'
      click_on 'Add Guest'
      expect(page).to have_css('#new_member_form')
    end

  end

end