class TransactionPresenter < BasePresenter
  presents :transaction

  def agent_column(profile_in_display)
    unless profile_in_display.try(:agent?)
      if transaction.agent
        content_tag :td, link_to(transaction.agent, profile_path(transaction.agent))
      else
        content_tag :td, ""
      end
    end
  end

  def vendor_column(profile_in_display)
    unless profile_in_display.try(:vendor?)
      if transaction.vendor
        content_tag :td, link_to(transaction.vendor, profile_path(transaction.vendor))
      else
        content_tag :td, ""
      end
    end
  end

  def profile_full_name_field
    unless transaction.client
      render partial: 'common/profile_autocomplete', 
            locals: {
                profile_id_field: 'transaction_client_id', 
                profile_id_name: 'transaction[client_id]',
                next_tab_index: 1
                }
    else
      content_tag :div do
        content = content_tag :h2, transaction.client.full_name, class: 'titleize'
        content << hidden_field_tag(:transaction_client_id, transaction.client.id, name: 'transaction[client_id]')
      end.html_safe
    end
  end

  def title
    if params[:action] == 'edit' || params[:action] == 'update'
      'Edit Transaction'
    else
      'New Transaction'
    end
  end
end