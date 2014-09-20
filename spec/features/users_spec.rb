require 'spec_helper'

describe "Users" do
  before(:each) do
    create_admin
  end
  
  describe "the signin process" do
    it "signs me in" do
      visit new_user_session_path
      fill_in 'user_username', :with => 'admin'
      fill_in 'user_password', :with => 'password'
      click_button 'Sign in'
      expect(current_path).to eq root_path
    end
  end

  describe "create" do
    before(:each) do
      sign_in
    end

    it "creates user" do
      visit new_user_path
      fill_in 'Username', with: 'test_create_01'
      fill_in 'Email', with: 'mode.email@noreply.com'
      fill_in 'Password', with: '12345678'
      select 'Moderator'
      click_button 'Create User'
      expect(page).to have_selector('table#users')
    end
  end

  describe "delete" do
    before(:each) do
      sign_in
    end
    
    it "activates and deactivates", js: true do
      user = User.find_by_username('moderator') || create(:moderator)
      visit users_path
      
      within("tr#user_#{user.id}") do
        click_on 'Delete'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content('Deleted')
        expect(page).to have_link('Activate')

        click_on 'Activate'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content('Active')
        expect(page).to have_link('Delete')
      end
    end
  end
end
