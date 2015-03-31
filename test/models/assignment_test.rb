require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
 
 	def setup
 		@assignment = assignments(:a1)
 	end

 	test "Assignments can get students" do
 		assert_equal 3, @assignment.students.count		
 	end

 	test "Assignments can get grades" do
 		assert_equal 1, @assignment.grades.count
 	end
end
