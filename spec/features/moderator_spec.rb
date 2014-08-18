require 'spec_helper'

describe "Moderator" do

  describe "Profile Index", :js do
    it "can view the data table" do
      user = create(:moderator) unless User.find_by_username('moderator')
      sign_in_as username: user.username, password: 'password'

      person = create(:person)
      company = create(:company)
      vendor = create(:vendor)

      visit profiles_path
      expect(page).to have_content(person.full_name)

      select 'CORPORATE'
      expect(page).to have_content(company.full_name)

      select 'VENDOR'
      expect(page).to have_content(vendor.full_name)
    end
  end
end