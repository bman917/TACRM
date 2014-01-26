class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.date :birth_day
      t.string :gender

      t.timestamps
    end
  end
end
