class CreateProfileVersions < ActiveRecord::Migration
  def change
    create_table :profile_versions do |t|
      t.references :profile, index: true
      t.references :version, index: true

      t.timestamps
    end
  end
end