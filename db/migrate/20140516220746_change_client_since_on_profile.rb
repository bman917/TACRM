class ChangeClientSinceOnProfile < ActiveRecord::Migration
  def up
    Profile.all.each do | profile |
      if profile.client_since
        begin
          d = profile.client_since.to_date
        rescue Exception => e
          begin
            d = Date.strptime(profile.client_since, '%m/%d/%Y')
          rescue
            puts "Unable to parse #{profile.client_since}"
            raise e
          end
        end
        
        profile.client_since = d.to_s
        profile.save
      end
    end
    change_column :profiles, :client_since, :date
  end

  def down
    change_column :profiles, :client_since, :string
  end

end
