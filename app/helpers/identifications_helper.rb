module IdentificationsHelper

  def render_identifications_table(identifications, options={})
    show_client_name = options[:show_client_name].nil? ? true : options[:show_client_name]
    show_edits = options[:show_edits].nil? ? true : options[:show_edits]
    remote = options[:remote].nil? ? false : options[:remote]

    render partial: 'identifications/table', locals: {identifications: identifications, show_client_name: show_client_name, show_edits: show_edits, remote: remote}
  end
end
