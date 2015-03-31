class TestsController < TasksController

	def index
		@assignments = @course.tests.order("due ASC")
		@students = get_data("students", "tests")
	end

	def update
		super(test_params)
	end

	def destroy
		super
	end

	private

	def test_params
		params.require(:test).permit(:name)
	end
end
