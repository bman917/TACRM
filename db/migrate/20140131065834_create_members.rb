class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :profile, index: true
      t.references :group, index: true
      t.string :relationship

      t.timestamps
    end
  end
end
