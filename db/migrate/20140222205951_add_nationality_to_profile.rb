class AddNationalityToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :nationality, :string
  end
end
