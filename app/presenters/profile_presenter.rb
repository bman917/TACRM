class ProfilePresenter < BasePresenter
  presents :profile

  def view
    if profile.deleted?
      link_to 'Restore', restore_profile_path(profile), method: :post, class: 'std_button', data: { confirm: "WARNING!!! Restore Profile for '#{profile.full_name}'?", remote: true}
    else
      link_to view_img(size: '27x24'), profile, class: 'slow_link'
    end
  end

  def phone
    if profile.phones.size == 0 && profile.unlocked?
      link_to add_img(alt: 'Add Phone', title: 'Add Phone'), 
        new_phone_path(profile_id: profile.id, source: 'index', remote: true),
        remote: true, class: 'slow_link'
    else
      profile.phones.first.try :display
    end
  end

  def address
    if profile.addresses.size == 0 && profile.unlocked?
      link_to add_img(alt: 'Add Address', title: 'Add Address'), 
        new_address_path(profile_id: profile.id, source: 'index', remote: true), 
        remote: true, class: 'slow_link'
    else
      truncate profile.addresses.first.try(:display)
    end
  end

  def client_since_label
    if profile.vendor?
      'Vendor Since'
    elsif profile.agent?
      'Agent Since'
    else
      'Client Since'
    end
  end

  def edit_link(options={}, path_params={}, html_options={})
    lock_check do
      options[:size] ||= '24x24'
      html_options[:remote] = true if html_options[:remote].nil?
      html_options[:id] = "e_prfl_#{profile.id}"
      html_options[:class] ||= 'slow_link'   
      link_to(edit_img(options), edit_profile_path(profile, path_params), html_options) if profile.unlocked?
    end
  end

  def deleted_css
    profile.deleted? ? 'deleted' : ''
  end

  def profile_css_id
    "profile_#{profile.id}"
  end

  def padlock_css_id
    if profile.locked?
      "p#{profile.id}_locked"
    else
      "p#{profile.id}_unlocked"
    end
  end

  def destroy_link(options={}, path_params={}, html_options={})
    if profile.deleted? && can?(:restore, Profile)
       link_to('DELETE', profile, method: :delete, class: 'std_button del', data: { confirm: "PERMANENTLY DELETE Profile for '#{profile.full_name}'?"})
    else
      lock_check do
        options[:size] ||= '24x24'
        link_to delete_img(options), delete_profile_path(profile), method: :delete, class: "remove_fields", data: { confirm: "WARNING!!! Delete Record for '#{profile.full_name}'?"}
      end
    end
  end

  def lock_check
    if profile.try(:locked?) 
      ""
    else
      yield
    end
  end

  def lock_link(link_params={}, img_params={size: '20x20'}, link_to_options={})

    link_to_options[:id]     ||= padlock_css_id
    link_to_options[:mothod] ||= :get
    link_to_options[:remote] = true if link_to_options[:remote].nil?
    link_to_options[:class] ||= 'spin_on_click'    

    if profile.deleted?
      ''
    elsif can?(:lock, Profile)
      if profile.locked?
        link_to_options[:data]  ||= { confirm: "Unlock Profile for '#{profile.full_name}'?" }
        link_to locked_img('Unlock Profile', img_params), 
        	unlock_profile_path(profile, link_params), link_to_options
      else
        link_to_options[:data]  ||= { confirm: "Lock Profile for '#{profile.full_name}'?" }
        link_to unlocked_img('Lock Profile', img_params), 
        	lock_profile_path(profile, link_params), link_to_options
      end
    else
      if profile.locked?
        locked_img('Profile is locked', size: '20x20')
      else
         unlocked_img('Profile is unlocked', size: '20x20')
      end
    end
  end
end