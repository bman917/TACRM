class ProfilePresenter < BasePresenter
  presents :profile
  # delegate :visa?, :passport?, :other?, to: :identification

  def lock_link(link_params={}, img_params={size: '20x20'}, link_to_options={method: :get, class: 'slow_link'})
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