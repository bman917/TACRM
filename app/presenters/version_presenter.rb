class VersionPresenter < BasePresenter
  presents :version
  
  def changeset
    if version.event == 'create'
      content_tag :p, 'New Record', class: 'n'
    else
      ch = version.changeset
      ch.delete(:updated_at)
      ch.delete(:created_at)
      
      if ch && ch.size > 0
        content_tag :ul do 
          ch.each do | key, array|
            if key == 'locked'
              concat content_tag :li, array.last ? 'LOCKED' : 'UNLOCKED'
            else   
              concat content_tag :li, "#{key.humanize}: #{array.first || "[blank]"} => #{array.last}"
            end
          end
        end
      else
         content_tag :p, "unkown", class:'u'
      end
    end
  end
end
