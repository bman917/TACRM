module DataTableHelper
  def columns_by_user_role
      columns = %w(view name type email number address locked)

      columns.push "edit" if can? :update, Profile
      columns.push "del" if can? :destroy, Profile

      return_val = '['
      columns.each do | column |
        return_val += "{\"data\": \"#{column}\"},"
      end

      return_val.chop + ']'
  end

  #* initial search filter */#
  def search_cols_by_user_role
    search_cols = '[null, null, {"search": $(\'#profile_type\').val()},null,null,null'
    search_cols += ',null' if can? :update, Profile
    search_cols += ',null' if can? :destroy, Profile
    search_cols += ']'
  end

  def column_defs
    targets = [0,4,5,6]
    targets.push 7 if can? :update, Profile
    targets.push 8 if can? :destroy, Profile

    "[{\"targets\": #{targets.to_s}, \"orderable\": false}]"
  end
end