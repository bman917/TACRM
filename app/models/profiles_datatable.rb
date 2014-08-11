class ProfilesDatatable
  delegate :present, :params, :h, :link_to, :number_to_currency, to: :@view


  def initialize(view)
    @view = view
  end

  def as_json(options={})
    {
      draw: params[:draw],
      recordsTotal: Profile.all_undeleted.count,
      recordsFiltered: profiles.count,
      data: data
    }
  end

  private

  def data
    filtered_profiles.map do | profile |
      profile_presenter = ProfilePresenter.new(profile,@view)
      {
        DT_RowId: profile_presenter.profile_css_id,
        DT_RowClass: profile_presenter.deleted_css,
        view: profile_presenter.view,
        name: profile.full_name,
        type: profile.profile_type,
        email: profile.email,
        number: profile_presenter.phone,
        address: profile_presenter.address,
        locked: profile_presenter.lock_link,
        edit: profile_presenter.edit_link({size: '18x18'}, {remote: 'true'}),
        del: profile_presenter.destroy_link(size: '14x14')
      }
      
    end
  end

  def filtered_profiles
    @filtered_profiles ||= profiles.limit(params[:length]).offset(params[:start])
  end

  def profiles
    @profiles ||= fetch_profiles
  end

  def fetch_profiles
    
    # puts "Profile Type Filter: #{profile_type_filter}"
    @profiles = Profile.apply_filter(profile_type: profile_type_filter)

    search_val = params[:search][:value]
    # puts "Search Value: #{search_val}"
    if search_val && !search_val.empty?
      @profile_unordered = @profiles.search_by_full_name(search_val)
    else
      @profile_unordered = @profiles
    end
    
    @profile_ordered = @profile_unordered

    params[:order].each do | order |
      index = order[1][:column].to_i || 0
      dir = order[1][:dir].to_sym || :desc
      column = columns[index]
      # puts "Order Column Index: #{index}, Column: #{column}, Dir: #{dir}"

      @profile_ordered = @profile_unordered.order(column=> dir) if column
    end

    @profile_ordered
  end

  def profile_type_filter
    params[:columns]["2"][:search][:value]
  end

  def columns
    @columns ||= if (profile_type_filter == "CORPORATE" || profile_type_filter == "VENDOR")
      [nil, :name, :profile_type, :email]
    else
      [nil, :first_name, :profile_type, :email]
    end
  end

end