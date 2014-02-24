class AddSet3DataToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :marital_status, :string
    add_column :profiles, :occupation, :string
    add_column :profiles, :employer, :string
    add_column :profiles, :job_position, :string
  end
end
