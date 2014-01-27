class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :owner, polymorphic: true
      t.string :line_one
      t.string :city
      t.string :state_region
      t.string :zipcode
      t.string :country

      t.timestamps
    end
  end
end
