class CreateIdentifications < ActiveRecord::Migration
  def change
    create_table :identifications do |t|
      t.string :foid_type
      t.string :foid
      t.string :notes
      t.references :profile, index: true

      t.timestamps
    end
  end
end
