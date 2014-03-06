require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "Test that Account is saved when Profile is saved" do
     p = Profile.new(first_name: "Juan", last_name: "Dela Cruz")
     p.account = Account.new(name: p.full_name)
     p.save!

     p.reload
     puts p.account.name
     assert p.account != nil

  end
end
