class AddSet2DataToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :contact_person, :string
    add_column :profiles, :business_type, :string
    add_column :profiles, :client_since, :string
    add_column :profiles, :credit_limit, :decimal
    add_column :profiles, :terms, :string
    add_column :profiles, :status, :string
    add_column :profiles, :lead_source, :string
  end
end
