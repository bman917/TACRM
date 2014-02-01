class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :profile, index: true
      t.text :note

      t.timestamps
    end
  end
end
