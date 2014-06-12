module ApplicationHelper

  def add_profile_link(options={})
    css_class = options[:class] || 'add_fields add_client_link'
    css_class << " slow_link"
    profile_type = options[:profile_type] || 'INDIVIDUAL'
    label = options[:label] || "Add #{profile_type}".upcase
    label = label.titleize if options[:titleize]

    link_to label, new_profile_by_type_path(profile_type.to_s.upcase), class: css_class, remote: true
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def current_version
    '1.6.8'
  end

  def add_role(key)
    "#{current_user.role}-#{key}"
  end

  def main_country_list
    ["Philippines","Japan", "Korea", "Singapore", "Thailand", "United States", "Schengen"]
  end

  def country_list
    ISO3166::Country.all.map {|c| c[0].titleize} 
  end

  def visa_country_list
    ["Philippines","Japan", "Korea", "Singapore", "Thailand", "United States", "Schengen", "--------------"] + country_list
  end

  def matched?(country)
    visa_country_list.include?(country) || (ISO3166::Country.find_all_by(:name, country) || ISO3166::Country.find_all_by(:alpha2, country) || ISO3166::Country.find_all_by(:alpha3, country)).empty? == false
  end


  def gender_types
    [
      ['M','M'],
      ['F','F']
    ]
  end

  def marital_status_types
    [
      ['Single','Single'],
      ['Married','Married']

    ]
  end

  def profile_types
    [
      ['INDIVIDUAL','INDIVIDUAL'],
      ['CORPORATE','CORPORATE'],
      ['AGENT','AGENT'],
      ['VENDOR','VENDOR'],
      ['No Contact Details', 'NO_CONACT_DETAILS'],
      ['No Address', 'NO_ADDRESS']

    ]
  end

  def foid_types
    [
      ['Passport','Passport'],
      ['Visa','Visa'],
      ['Drivers License', 'Drivers License'],
      ['Company ID', 'Company ID'],
      ['SSS ID', 'SSS ID'],
      ['TIN', 'TIN'],
      ['Other', 'Other']
    ]
  end
  def phone_types
    [
      ['Landline','Landline'],
      ['Mobile','Mobile'],
      ['Fax','Fax']
    ]
  end

  def section_hide_link(id)
    link_to '+', '', {id: id, class: 'section_hide_link'}
  end 

  def profile_selector(f)
    f.collection_select :profile_id, Profile.where(profile_type: 'INDIVIDUAL'), :id, :full_name, {}, class: 'focus_on_toggle'
  end

  def add_link(params={text: 'Add', id: 'add_link'})
    link_to params[:text], '', id: params[:id], class: "add_fields no-print"
  end

  def format_date(date)
    date.to_time.to_s(:med)
  end

  def launch_modal_form_link(params)
    text = params[:text] || 'Add'
    source = params[:source] || 'show'
    path = params[:path] 
    remote = true if params[:remote] == nil
    url = send(path, profile_id: params[:profile_id], source: source, remote: remote)
    link_to(text, url, remote: remote, class: 'std_button add_overlay')
  end


end
