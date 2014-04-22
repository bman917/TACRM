class ChangeVersionObjectChanges < ActiveRecord::Migration
  def change
  	change_column :versions, :object_changes, :text
  end
end
