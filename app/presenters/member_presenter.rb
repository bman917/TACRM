class MemberPresenter < BasePresenter
  presents :member

  def profile_full_name_field
      text_field_tag :profile_full_name, [], size: 35, 
        placeholder: "Start typing and profile names will appear...",  
        autofocus: true, class: 'text'
  end
end