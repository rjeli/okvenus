require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user validation" do
  	user = User.new
  	assert_not user.save, "saved user without email"
  end

  test "a new user should have a question to answer" do
  	user = User.new
  	assert user.unanswered_question
  end

  test "a new user should have no matches" do
  	user = User.new
  	assert user.get_matches.map{|u| u[:shared]}.all? {|x| x == 0}
  end
end
