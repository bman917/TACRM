class AddDescriptionToIdentifications < ActiveRecord::Migration
  def change
    add_column :identifications, :description, :string
  end
end
