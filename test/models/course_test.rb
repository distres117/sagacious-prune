require 'test_helper'

class CourseTest < ActiveSupport::TestCase

	def setup
		@course = courses(:c1)
	end

	test "Course can get assignments" do
		assert_equal 5, @course.assignments.count
	end

	test "Course can get students" do
		assert_equal 3, @course.students.count
	end

	test "Course can calculate final grade" do 
		student = students(:s1)
		assert_equal 100, @course.get_final_grade(student)
	end


end
