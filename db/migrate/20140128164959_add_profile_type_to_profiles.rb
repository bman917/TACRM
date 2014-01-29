class AddProfileTypeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_type, :string
    add_column :profiles, :name, :string
  end
end
