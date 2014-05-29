require 'spec_helper'

describe Note do
  before(:each) do
    sign_in
  end

  describe "Create", js: true do
    before(:each) do
      @p = create(:person, first_name: 'Note', last_name: 'Tester')
      visit profiles_path
      view_profile(@p)
      click_on 'Notes'
      click_on 'Add Note'
    end
    
    it "opens create form" do
      click_on 'Close'
      sleep 0.25
      expect(page).to have_no_css('#new_note_form') 
      expect(page).to have_no_css('#modal_form_container') 
    end

    it "can save a note" do

      expect(find_by_id('note_profile_id', :visible => false).value).to eq @p.id.to_s

      fill_in 'note_note', with: 'Lorem ipsum dolor'
      click_button 'Save'
      expect(page).to have_content('Lorem ipsum dolor')
    end
  end
end