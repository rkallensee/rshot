require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  fixtures :users

  test "profile validation" do
    profile = Profile.new
    assert !profile.save

    profile = Profile.new({:user_id => users(:one).id})
    assert !profile.save

    profile = Profile.new({:user_id => users(:one).id, :nick => "12"})
    assert !profile.save

    profile = Profile.new({:user_id => users(:one).id, :nick => "123"})
    assert profile.save

    assert_equal profiles(:one).to_param, "raphael"
  end
end
