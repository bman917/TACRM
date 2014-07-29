require 'spec_helper'

describe Note do
  before(:each) do
    sign_in
  end

  describe "Create", js: true do
    before(:each) do
      @p = create(:person, first_name: 'Note', last_name: 'Tester')
      visit profile_path(@p)
      click_on 'Notes'
      click_on 'Add Note'
    end
    
    it "can close form" do
      click_on 'Close'
      sleep 0.25
      expect(page).to have_no_css('#new_note_form') 
      expect(page).to have_no_css('#modal_form_container') 
    end

    it "can save a note" do

      #Form for the new note should have a hidden input field with css id = note_profile_id
      expect(find_by_id('note_profile_id', :visible => false).value).to eq @p.id.to_s

      fill_in 'note_note', with: 'Lorem ipsum dolor'
      click_button 'Save'
      expect(page).to have_content('Lorem ipsum dolor')
      expect(page).to have_css('tr.new')
    end
  end

  describe "Edit and Delete", js: true do
    before(:each) do
      @p = create(:person_with_notes)
      @note_css = "tr#note_#{@p.notes.first.id}"
      visit profile_path(@p)
      click_on 'Notes'
    end

    it "Opens Edit Form" do
      within(@note_css) do
        click_on 'Edit'
      end
      expect(page).to have_css('#new_note_form')

      fill_in 'note_note', with: 'Edit ipsum dolor'
      click_button 'Save'
      expect(page).to have_content('Edit ipsum dolor')
      expect(page).to have_css('tr.new')
    end

    it "can be deleted" do
      within(@note_css) do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
      end
      assert has_no_css?(@note_css)
    end

  end
end