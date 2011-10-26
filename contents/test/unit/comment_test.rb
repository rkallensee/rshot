require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  fixtures :pictures

  test "validate required comment profile id and comment text" do
    comment = pictures(:one).comments.new()
    assert !comment.save

    comment = pictures(:one).comments.new({:profile_id => profiles(:one).id})
    assert !comment.save

    comment = pictures(:one).comments.new({:profile_id => profiles(:one).id, :comment => "Awesome!"})
    assert comment.save
  end
end
