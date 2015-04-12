require 'test_helper'

class StudentTest < ActiveSupport::TestCase

	def setup
		@student = students(:s1)
	end

	test "student can get grades" do
		assert_equal 5, @student.grades.count
	end

	test "student can get assignments" do
		assert_equal 7, @student.assignments.count
	end

	test "student can get notes" do
		assert_equal 1, @student.notes.count
	end


	
end
