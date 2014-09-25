require 'spec_helper'

describe 'DocImage' do
  before(:each) do
    sign_in
    @p = create(:person)
    @p.identifications.create(foid_type: "Passport", foid: "DOC UPLOAD TEST 1")
    @p.identifications.create(foid_type: "Passport", foid: "DOC UPLOAD TEST 2")
    visit profile_path(@p)
    click_on 'Documents'

  end

  #
  #TO DO: break this test to smaller parts...
  #
  it 'has an upload feature', :js do
    within "##{@p.identifications.first.css_id}" do
      click_on 'upload'
    end
    expect(page).to have_css("form#upload_image")
    expect(page).to have_content("upload image")
    expect(page).to have_field("identification_doc_image")

    attach_file('identification_doc_image',"#{Rails.root}/app/assets/images/logo.png")
    #click_on 'Upload' #click Upload button
    #Sep 25: jQuery file upload added. It will submit the form automatically upon
    #        file selection.

    within "##{@p.identifications.first.css_id}" do
      expect(page).to have_css("img[alt='logo.png']")
      click_on 'logo.png'
    end
    expect(page).to have_css("div#view_doc_image")
    within "#view_doc_image" do
      expect(page).to have_content("logo.png")
    end
    close_modal_form

    #Expect a 'warning' message on the upload 
    #form when there is an existing image
    within "##{@p.identifications.first.css_id}" do
      click_on 'upload'
    end
    expect(page).to have_content('WARNING')
    expect(page).to have_content('This will replace existing image')
    close_modal_form


    #Test deleting the image
    within "##{@p.identifications.first.css_id}" do
      click_on 'logo.png'
    end
    within "#view_doc_image" do
      click_on 'Delete'
      page.driver.browser.switch_to.alert.accept
    end
    within "##{@p.identifications.first.css_id}" do
      expect(page).to have_no_css("img[alt='logo.png']")
    end

    #View image as viewer
    click_on 'Logout'
    sign_in_as role: :viewer
    visit profile_path(@p)
    click_on 'Documents'
    within "##{@p.identifications.first.css_id}" do
      expect(page).to have_css("img[alt='logo.png']")
      click_on 'logo.png'
    end
    expect(page).to have_css("div#view_doc_image")
    within "#view_doc_image" do
      expect(page).to have_content("logo.png")
    end   
  end

  it 'only accepts image files', :js do
    within "##{@p.identifications.first.css_id}" do
      click_on 'upload'
    end

    attach_file('identification_doc_image',"#{Rails.root}/app/assets/javascripts/application.js")
    page.driver.browser.switch_to.alert.accept    
    expect(page).to have_no_css("img[alt='application.js']")
    
  end

  def close_modal_form
    click_on 'Close' #close view image form
    sleep 1    
  end
end