class SetLockedColumnDefaultValue < ActiveRecord::Migration
  def up
  	change_column :profiles, :locked, :boolean, default: false
  	Profile.update_all(locked: false)

  end

  def down
  	change_column :profiles, :locked, :boolean, default: nil
  	Profile.update_all(locked: nil)
  end
end
