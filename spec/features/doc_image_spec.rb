require 'spec_helper'

describe 'DocImage' do
  before(:each) do
    sign_in
  end

  it 'has an upload link', :js do
    p = create(:person)
    p.identifications.create(foid_type: "Passport", foid: "DOC UPLOAD TEST")
    visit profile_path(p)
    click_on 'Documents'
    within "##{p.identifications.first.css_id}" do
      click_on 'upload'
    end
    expect(page).to have_css("form#upload_image")
    expect(page).to have_content("upload image")
    expect(page).to have_field("identification_doc_image")

    attach_file('identification_doc_image',"#{Rails.root}/app/assets/images/logo.png")
    click_on 'Upload'
    expect(page).to have_css('img', text: 'logo.png')

  end
end