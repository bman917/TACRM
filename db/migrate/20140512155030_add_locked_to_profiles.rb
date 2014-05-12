class AddLockedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :locked, :boolean
  end
end
