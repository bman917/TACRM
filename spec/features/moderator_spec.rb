require 'spec_helper'

describe "Moderator" do

  describe "Profile Index", :js do
    it "can view the data table" do
      sign_in_as role: :moderator

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