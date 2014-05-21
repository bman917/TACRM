require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  test "Test that Account is saved when Profile is saved" do
     p = create(:person)
     p.account = Account.new(name: p.full_name)
     p.save!

     p.reload
     assert p.account != nil
  end


end
