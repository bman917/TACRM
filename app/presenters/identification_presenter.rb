class IdentificationPresenter < BasePresenter
  presents :identification
  delegate :visa?, :passport?, :other?, to: :identification

  def doc_image_column(remote=nil, show_edits=nil)
    if identification.doc_image.url.nil? == false
      link_to(image_tag(download_doc_image_path(identification, :thumb), 
        alt: identification.doc_image.disp), 
        view_doc_image_path(identification), remote: true)
    else
      ""
    end
  end

  def new_doc_image_link(remote=nil)
    lock_check do
      link_to image_tag('upload-xl.png', size: '20x20', title: 'Upload Image', alt: 'upload'), new_doc_image_path(identification), remote: defined?(remote) && remote
    end
  end

  def destroy_link
    lock_check do
      link_to delete_img, identification, remote: true, method: :delete, title: 'Delete!!!', class: "remove_fields no-print", data: {confirm: "Delete [#{identification.foid_type} - #{identification.foid}]?"}
    end
  end

  def edit_link(remote=nil)
    lock_check do
      link_to edit_img, edit_identification_path(identification), title: 'Edit', class: 'efoid', remote: defined?(remote) && remote
    end
  end

  def lock_check
    if identification.try(:profile).try(:locked?)
      locked_img
    else
      yield
    end
  end

  def title
    if params[:action] == 'edit' || params[:action] == 'update'
      'Edit Document'
    else
      'New Document'
    end
  end

  def profile_full_name_field
    unless identification.profile
      text_field_tag :profile_full_name, [], size: 35, 
        placeholder: "Start typing and profile names will appear...",  
        autofocus: true, class: 'text'
    else
      content_tag :h2, identification.profile.full_name, class: 'titleize'
    end
  end

  def profile_select_legend
    identification.profile ? 'Client' : 'Select Client'
  end

  def client_name_label
    unless identification.profile
      content_tag :div do
        content = content_tag :label, "Name: "
          content << image_tag("question.png", 
            size: "14x14", 
            title: "Start typing and profile names will appear. Select a profile from the drop down.")
      end.html_safe
    end
  end

  def profile_link
    if identification.profile
      link_to identification.profile.full_name, identification.profile 
    else
      "No Profile!"
    end
  end

  def type
    if visa?
      "#{identification.country} #{identification.visa_type} #{identification.foid_type} "
    else
      "#{identification.country} #{identification.foid_type}"
    end
  end

  def date_issued
    identification.date_issued.try(:to_time).try(:to_s,:med)
  end

  def expiration_date
    identification.expiration_date.try(:to_time).try(:to_s,:med)
  end

  def other_details
    content_tag :ul do 

      if passport?
        content_tag(:li, "Issued By: #{identification.issued_by}")

      elsif visa?
        content = content_tag(:li, "Entry Date: #{identification.try(:entry_date).try(:to_time).try(:to_s,:med)}")
        content << content_tag(:li, "Max Stay: #{identification.max_stay}")
      elsif other?
        content_tag(:li, identification.description)
      end
    end.html_safe
  end
end