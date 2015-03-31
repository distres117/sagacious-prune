require 'test_helper'

class UserTest < ActiveSupport::TestCase

	def setup
		@user = users(:u1)
	end

	test "User can get courses" do
		assert_equal 3, @user.courses.count 
	end
end
