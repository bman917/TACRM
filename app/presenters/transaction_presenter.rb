class TransactionPresenter < BasePresenter
  presents :transaction

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
        content = content_tag :h2, transaction.client.full_name
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