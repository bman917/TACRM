class AddEntryDateToIdentifications < ActiveRecord::Migration
  def change
  	remove_column :identifications, :entry_date, :string
  	add_column :identifications, :entry_date, :date
  end
end
