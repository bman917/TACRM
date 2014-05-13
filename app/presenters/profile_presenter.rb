class ProfilePresenter < BasePresenter
  presents :profile

  def profile_css_id
    "profile_#{profile.id}"
  end

  def padlock_css_id
    "#{profile.id}_padlock"
  end

  def destroy_link
    # lock_check do
      link_to delete_img, profile, method: :delete, class: "remove_fields", data: { confirm: "Delete Record for '#{profile.full_name}'?" }
    # end
  end

  def lock_check
    if profile.try(:locked?)
      "-"
    else
      yield
    end
  end

  def lock_link(link_params={}, img_params={size: '20x20'}, link_to_options={})

    link_to_options[:id]     ||= padlock_css_id
    link_to_options[:mothod] ||= :get
    link_to_options[:remote] = true if link_to_options[:remote].nil?
    link_to_options[:class]   ||= 'spin_on_click'

    if can? :lock, Profile
      if profile.locked?
        link_to locked_img('Unlock Profile', img_params), 
        	unlock_profile_path(profile, link_params), link_to_options
      else
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