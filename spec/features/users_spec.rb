require 'spec_helper'

describe "Users" do
  before(:each) do
    @admin = create(:admin)
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

  describe "Profile Index Filters" do
    before(:each) do
      sign_in
    end

    it "preselects according to the profule type filter" do 
      click_on 'Agents'
      expect(find(:css, 'select#profile_type').value).to eq 'AGENT'
      click_on 'Vendor'
      expect(find(:css, 'select#profile_type').value).to eq 'VENDOR'
    end

  end
end

def sign_in 
  visit new_user_session_path
  fill_in 'user_username', :with => 'admin'
  fill_in 'user_password', :with => 'password'
  click_button 'Sign in'
end
