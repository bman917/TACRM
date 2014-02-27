class AddPassportDetailsToIdentifications < ActiveRecord::Migration
  def change
    add_column :identifications, :date_issued, :date
    add_column :identifications, :expiration_date, :date
    add_column :identifications, :issued_by, :string
    add_column :identifications, :country, :string
    add_column :identifications, :sub_type, :string
    add_column :identifications, :entry_date, :string
    add_column :identifications, :max_stay, :string
  end
end
