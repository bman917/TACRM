require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user bart is NOT an admin" do
     bart = users(:bart)
     assert_not bart.admin?, "User Bart is is not an admin"
  end

  test "user bart is a viewer" do
     bart = users(:bart)
     assert bart.viewer?, "User Bart is is not an admin"
  end

end
