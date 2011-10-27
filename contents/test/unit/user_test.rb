require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :profiles

  test "user model basics" do
    user = User.new
    assert !user.save

    user = User.new({:email => "foo@bar.net"})
    user.password = "bacardi"
    user.password_salt = "b4z"
    assert user.valid?
    assert user.save

    profile = Profile.find(3)
    # find out if the profile was automatically created
    assert_equal profile, user.profile
  end
end
