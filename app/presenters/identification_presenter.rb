class IdentificationPresenter < BasePresenter
  presents :identification
  delegate :visa?, :passport?, to: :identification

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
      end
    end.html_safe
  end
end