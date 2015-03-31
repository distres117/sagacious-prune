require 'test_helper'

class GradeTest < ActiveSupport::TestCase

	def setup
		@grade = grades(:g1)
	end
	
	test "Grade can get student" do
		assert @grade.student.first == "Jose"
	end

	test "Grade can get assignment" do
		assert @grade.assignment.name == "Hw 1"
	end
end
