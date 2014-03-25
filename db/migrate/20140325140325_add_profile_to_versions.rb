class AddProfileToVersions < ActiveRecord::Migration
  def change
    add_reference :versions, :profile, index: true
  end
end
